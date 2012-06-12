class KDViewController extends KDController
  constructor:(options,data)->
    @setData data
    @setOptions options
    @setDelegate options.delegate if options?.delegate?
    super options,data
    
    if options?.view?
      @setView options.view

  setData:(data)->
    @data = data ? {}
  getData:-> @data

  setOptions:(options)->
    @options = options ? {}
  getOptions:-> @options

  bringToFront:(options = {}, view = @getView())->
    @propagateEvent
      KDEventType                 : 'ApplicationWantsToBeShown'
      globalEvent  : yes
    ,
      options : options
      data    : view

  initAndBringToFront:(options, callback)->
    @bringToFront()
    callback()

  loadView:(mainView)->

  getView:()-> @mainView
  setView:(aViewInstance)->
    @mainView = aViewInstance
    if aViewInstance.isViewReady() then @loadView @getView()
    else
      aViewInstance.registerListener KDEventTypes : ['ViewAppended'], callback : @loadView, listener : @
      aViewInstance.registerListener KDEventTypes : 'KDObjectWillBeDestroyed', listener : @, callback : ->@destroy()
    
  # DELEGATE METHOD
  hashDidChange:(params,query)->