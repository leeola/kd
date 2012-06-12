###
todo:

  - make addLayer implementation more clear, by default adding a layer
    should set a listener for next ReceivedClickElsewhere and remove the layer automatically
    2012/5/21 Sinan

###
class KDWindowController extends KDController
  
  constructor:(options,data)->
    @windowResizeListeners = {}
    @keyView
    @scrollingEnabled = yes
    @bindEvents()
    @setWindowProperties()
    
    @layers = layers = []
    document.body.addEventListener 'mousedown', (e)=>
      $('.twipsy').remove() # temporary for beta
      @setDragInAction no # for cases when dragleave doesn't fire
      lastLayer = layers[layers.length-1]
      if lastLayer and $(e.target).closest(lastLayer?.$()).length is 0
        lastLayer.propagateEvent (KDEventType: 'ReceivedClickElsewhere'), e
    , yes

    document.body.addEventListener 'mouseup', (e)=>
      @propagateEvent (KDEventType: 'ReceivedMouseUpElsewhere'), e
    , yes
    
    super
  
  addLayer: (layer)->
    unless layer in @layers
      @layers.push layer
  
  removeLayer: (layer)->
    index = @layers.indexOf(layer)
    @layers.splice index, 1
  
  bindEvents:()->

    $(window).bind "keydown keyup keypress",@key
    $(window).bind "resize",(event)=>
      @setWindowProperties event
      @notifyWindowResizeListeners event

    document.body.addEventListener "dragenter", (event)=>
      unless @dragInAction
        @propagateEvent (KDEventType: 'DragEnterOnWindow'), event
        @setDragInAction yes
    , yes

    document.body.addEventListener "dragleave", (event)=>
      unless 0 < event.clientX < @winWidth and
             0 < event.clientY < @winHeight
        @propagateEvent (KDEventType: 'DragExitOnWindow'), event
        @setDragInAction no
    , yes

    document.body.addEventListener "drop", (event)=>
      @propagateEvent (KDEventType: 'DragExitOnWindow'), event
      @propagateEvent (KDEventType: 'DropOnWindow'), event
      @setDragInAction no
    , yes
  
  setDragInAction:(action = no)->
    $('body')[if action then "addClass" else "removeClass"]("dragInAction")
    @dragInAction = action
  
  setMainView:(view)->
    @mainView = view
  
  getMainView:(view)->
    @mainView

  revertKeyView:->

    if @keyView isnt @oldKeyView
      @setKeyView @oldKeyView

  setKeyView:(newKeyView)->
    
    return if newKeyView is @keyView

    newKeyViewAcceptsKeyStatus = ()->
      return not newKeyView? or newKeyView?.acceptsKeyStatus()
    oldKeyViewResignsKeyStatus = ()->
      return not @keyView? or @keyView.resignsKeyStatus()

    if newKeyViewAcceptsKeyStatus() and oldKeyViewResignsKeyStatus()
      @oldKeyView = @keyView
      @keyView = newKeyView
      newKeyView?.propagateEvent KDEventType : 'KDViewBecameKeyView'
      @propagateEvent (KDEventType: 'WindowChangeKeyView', globalEvent : yes), view: newKeyView
  
  getKeyView:()->
    @keyView

  key:(event)=>
    # log @keyView, 'key view'
    @keyView?.handleEvent event

  allowScrolling:(shouldAllowScrolling)->
    @scrollingEnabled = shouldAllowScrolling
    
  registerWindowResizeListener:(instance)->
    @windowResizeListeners[instance.id] = instance
    instance.registerListener
      KDEventTypes  : "KDObjectWillBeDestroyed"
      listener      : @
      callback      : =>
        delete @windowResizeListeners[instance.id]
  
  setWindowProperties:(event)->
    @winWidth  = $(window).width()
    @winHeight = $(window).height()
  
  notifyWindowResizeListeners:(event,throttle = no, duration = 17)->
    event or= type : "resize"
    if throttle
      clearTimeout @resizeNotifiersTimer if @resizeNotifiersTimer
      @resizeNotifiersTimer = setTimeout ()=>
        for key,instance of @windowResizeListeners
          instance._windowDidResize? event
      , duration
    else
      for key,instance of @windowResizeListeners
        instance._windowDidResize? event

  # notifyWindowResizeListeners: __utils.throttle (event)=>
  #   event or= type : "resize"
  #   for key,instance of @windowResizeListeners
  #     instance._windowDidResize? event
  # ,50