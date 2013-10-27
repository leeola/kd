# utils singleton
# -------------------------
#
# -------------------------

__utils =

  idCounter : 0

  extend:(obj)->
    for key, val of obj
      if @[key] then throw new Error "#{key} is already registered"
      else @[key] = val

  formatPlural:(count, noun)->
    "#{count or 0} #{if count is 1 then noun else Inflector.pluralize noun}"

  selectText:(element, selectionStart, selectionEnd)->
    doc   = document
    if doc.body.createTextRange
      range = document.body.createTextRange()
      range.moveToElementText element
      range.select()
    else if window.getSelection
      selection = window.getSelection()
      range     = document.createRange()
      range.selectNodeContents element
      selection.removeAllRanges()
      selection.addRange range

  getCallerChain:(args, depth)->
    {callee:{caller}} = args
    chain = [caller]
    while depth-- and caller = caller?.caller
      chain.push caller
    chain

  getUniqueId: do -> i = 0; -> "kd-#{i++}"

  getRandomNumber :(range=1e6, min=0)->
    res = Math.floor Math.random()*range+1
    return if res > min then res else res + min

  uniqueId : (prefix)->
    id = __utils.idCounter++
    if prefix? then "#{prefix}#{id}" else id

  getRandomRGB :->
    {getRandomNumber} = @
    "rgb(#{getRandomNumber(255)},#{getRandomNumber(255)},#{getRandomNumber(255)})"

  getRandomHex : ->
    # hex = (Math.random()*0xFFFFFF<<0).toString(16)
    hex = (Math.random()*0x999999<<0).toString(16)
    while hex.length < 6
      hex += "0"
    "##{hex}"

  curry:(obligatory, optional)->
    obligatory + if optional then ' ' + optional else ''

  parseQuery:do->
    params  = /([^&=]+)=?([^&]*)/g    # for chunking the key-val pairs
    plusses = /\+/g                   # for converting plus signs to spaces
    decode  = (str)-> decodeURIComponent str.replace plusses, " "
    parseQuery = (queryString = location.search.substring 1)->
      result = {}
      result[decode m[1]] = decode m[2]  while m = params.exec queryString
      result

  stringifyQuery:do->
    spaces = /\s/g
    encode =(str)-> encodeURIComponent str.replace spaces, "+"
    stringifyQuery = (obj)->
      Object.keys(obj).map((key)-> "#{encode key}=#{encode obj[key]}").join('&').trim()

  capAndRemovePeriods:(path)->
    newPath = for arg in path.split "."
      arg.capitalize()
    newPath.join ""

  slugify:(title = "")->
    url = String(title)
      .toLowerCase()                # change everything to lowercase
      .replace(/^\s+|\s+$/g, "")    # trim leading and trailing spaces
      .replace(/[_|\s]+/g, "-")     # change all spaces and underscores to a hyphen
      .replace(/[^a-z0-9-]+/g, "")  # remove all non-alphanumeric characters except the hyphen
      .replace(/[-]+/g, "-")        # replace multiple instances of the hyphen with a single instance
      .replace(/^-+|-+$/g, "")      # trim leading and trailing hyphens

  stripTags:(value)->
    value.replace /<(?:.|\n)*?>/gm, ''

  decimalToAnother:(n, radix) ->
    hex = []
    for i in [0..10]
      hex[i+1] = i

    s = ''
    a = n
    while a >= radix
      b = a % radix
      a = Math.floor a / radix
      s += hex[b + 1]

    s += hex[a + 1]
    n = s.length
    t = ''
    for i in [0...n]
      t = t + s.substring n - i - 1, n - i
    s = t
    s

  applyMarkdown: (text)->
    # problems with markdown so far:
    # - links are broken due to textexpansions (images too i guess)
    return null unless text

    marked text,
      gfm       : true
      pedantic  : false
      sanitize  : true
      highlight :(text, lang)->
        if hljs.LANGUAGES[lang]?
        then hljs.highlight(lang,text).value
        else text

  createExternalLink: (href) ->
    tag = document.createElement "a"
    tag.href = if href.indexOf("http") > -1 then href else "http://#{href}"
    tag.target = "_blank"
    document.body.appendChild tag
    tag.click()
    document.body.removeChild tag

  wait: (duration, fn)->
    if "function" is typeof duration
      fn = duration
      duration = 0
    return setTimeout fn, duration

  killWait:(id)->
    clearTimeout id if id
    return null

  repeat: (duration, fn)->
    if "function" is typeof duration
      fn = duration
      duration = 500
    setInterval fn, duration

  killRepeat:(id)-> clearInterval id

  defer:do ->
    # this was ported from browserify's implementation of "process.nextTick"
    queue = []
    if window?.postMessage and window.addEventListener
      window.addEventListener "message", ((ev) ->
        if ev.source is window and ev.data is "kd-tick"
          ev.stopPropagation()
          do queue.shift()  if queue.length > 0
      ), yes
      (fn) -> queue.push fn; window.postMessage "kd-tick", "*"
    else
      (fn) -> setTimeout fn, 1

  getCancellableCallback:(callback)->
    cancelled = no
    kallback = (rest...)-> callback rest...  unless cancelled
    kallback.cancel = -> cancelled = yes
    kallback

  # ~ GG
  # Returns a new callback which calls the failcallback if
  # first callback not finish its job in given timeout (default is 5000ms)
  #
  # Usage:
  #
  # Let assume that you have this:
  #
  #   asyncFunc (data)->
  #     doSomethingWith data
  #
  # To set a timeout for it eg. 500ms:
  #
  #   asyncFunc getTimedOutCallBack (data)->
  #     doSomethingWith data
  #   , ->
  #     console.log "asyncFunc is not responded in 500ms."
  #   , 500
  #
  getTimedOutCallback:(callback, failcallback, timeout=5000)->
    cancelled = no
    kallback  = (rest...)->
      clearTimeout fallbackTimer
      callback rest...  unless cancelled

    fallback = (rest...)->
      failcallback rest...  unless cancelled
      cancelled = yes

    fallbackTimer = setTimeout fallback, timeout
    kallback

  # Returns a new callback which calls the failcallback if
  # first callback doesn't finish its job within timeout.
  #
  # Also, keeps track of start and end times.
  #
  # Let's assume that you have this:
  #
  #   asyncFunc (data)-> doSomethingWith data
  #
  # To set a timeout for 500ms:
  #
  #   asyncFunc ,\
  #     KD.utils.getTimedOutCallbackOne
  #       name     :"asyncFunc" // optional, logs to KD.utils.timers
  #       timeout  : 500        // defaults to 5000
  #       onSucess : (data)->
  #       onTimeout: ->
  #       onResult : ->         // called when result comes after timeout
  getTimedOutCallbackOne: (options={})->
    timerName = options.name      or "undefined"
    timeout   = options.timeout   or 10000
    onSuccess = options.onSuccess or ->
    onTimeout = options.onTimeout or ->
    onResult  = options.onResult  or ->

    timedOut = no
    kallback = (rest...)=>
      clearTimeout fallbackTimer
      @updateLogTimer timerName, fallbackTimer, Date.now()

      if timedOut then onResult rest... else onSuccess rest...

    fallback = (rest...)=>
      timedOut = yes
      @updateLogTimer timerName, fallbackTimer

      onTimeout rest...

    fallbackTimer = setTimeout fallback, timeout
    @logTimer timerName, fallbackTimer, Date.now()

    kallback.cancel =-> clearTimeout fallbackTimer
    kallback

  logTimer:(timerName, timerNumber, startTime)->
    log "logTimer name:#{timerName}"

    @timers[timerName] ||= {}
    @timers[timerName][timerNumber] =
      start  : startTime
      status : "started"

  updateLogTimer:(timerName, timerNumber, endTime)->
    timer     = @timers[timerName][timerNumber]
    status    = if endTime then "ended" else "failed"
    startTime = timer.start
    elapsed   = endTime-startTime
    timer     =
      start   : startTime
      end     : endTime
      status  : status
      elapsed : elapsed

    @timers[timerName][timerNumber] = timer

    log "updateLogTimer name:#{timerName}, status:#{status} elapsed:#{elapsed}"

  timers: {}

  stopDOMEvent :(event)->
    return no  unless event
    event.preventDefault()
    event.stopPropagation()
    return no

  utf8Encode:(string)->
    string = string.replace(/\r\n/g, "\n")
    utftext = ""
    n = 0

    while n < string.length
      c = string.charCodeAt(n)
      if c < 128
        utftext += String.fromCharCode(c)
      else if (c > 127) and (c < 2048)
        utftext += String.fromCharCode((c >> 6) | 192)
        utftext += String.fromCharCode((c & 63) | 128)
      else
        utftext += String.fromCharCode((c >> 12) | 224)
        utftext += String.fromCharCode(((c >> 6) & 63) | 128)
        utftext += String.fromCharCode((c & 63) | 128)
      n++
    utftext

  utf8Decode:(utftext)->
    string = ""
    i = 0
    c = c1 = c2 = 0
    while i < utftext.length
      c = utftext.charCodeAt(i)
      if c < 128
        string += String.fromCharCode(c)
        i++
      else if (c > 191) and (c < 224)
        c2 = utftext.charCodeAt(i + 1)
        string += String.fromCharCode(((c & 31) << 6) | (c2 & 63))
        i += 2
      else
        c2 = utftext.charCodeAt(i + 1)
        c3 = utftext.charCodeAt(i + 2)
        string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63))
        i += 3
    string

  # Return true x% of time based on argument.
  #
  # Example:
  #   runXpercent(10) => returns true 10% of the time
  runXpercent: (percent)->
    chance = Math.floor(Math.random() * 100)
    chance <= percent

  shortenUrl: (url, callback)->
    request = $.ajax "https://www.googleapis.com/urlshortener/v1/url",
      type        : "POST"
      contentType : "application/json"
      data        : JSON.stringify {longUrl: url}
      timeout     : 4000
      dataType    : "json"

    request.done (data)=>
      callback data?.id or url, data

    request.error ({status, statusText, responseText})->
      error "URL shorten error, returning self as fallback.", status, statusText, responseText
      callback url

  formatBytesToHumanReadable: (bytes) ->
    minus = ''
    if bytes < 0
      minus  = '-'
      bytes *= -1
    thresh    = 1024
    units     = ["kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
    unitIndex = -1
    return "#{bytes} B"  if bytes < thresh
    loop
      bytes /= thresh
      ++unitIndex
      break unless bytes >= thresh

    return "#{minus}#{bytes.toFixed 2} #{units[unitIndex]}"

###
//     Underscore.js 1.3.1
//     (c) 2009-2012 Jeremy Ashkenas, DocumentCloud Inc.
//     Underscore is freely distributable under the MIT license.
//     Portions of Underscore are inspired or borrowed from Prototype,
//     Oliver Steele's Functional, and John Resig's Micro-Templating.
//     For all details and documentation:
//     http://documentcloud.github.com/underscore
###

`
__utils.throttle = function(func, wait) {
  var context, args, timeout, throttling, more;
  var whenDone = __utils.debounce(function(){ more = throttling = false; }, wait);
  return function() {
    context = this; args = arguments;
    var later = function() {
      timeout = null;
      if (more) func.apply(context, args);
      whenDone();
    };
    if (!timeout) timeout = setTimeout(later, wait);
    if (throttling) {
      more = true;
    } else {
      func.apply(context, args);
    }
    whenDone();
    throttling = true;
  };
};

// Returns a function, that, as long as it continues to be invoked, will not
// be triggered. The function will be called after it stops being called for
// N milliseconds.
__utils.debounce = function(func, wait) {
  var timeout;
  return function() {
    var context = this, args = arguments;
    var later = function() {
      timeout = null;
      func.apply(context, args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
};
`
