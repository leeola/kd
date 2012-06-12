class KDTabViewWithForms extends KDTabView
  constructor:(options,data)->
    options = $.extend
      navigable : yes
      goToNextFormOnSubmit : yes
    ,options
    super options,data
    @forms = {}
    @hideHandleCloseIcons()
    {forms} = @getOptions()
    if forms
      @createTabs forms = @sanitizeOptions forms
      @showPane @panes[0]
    if forms.length is 1
      @hideHandleContainer()
    
  sanitizeOptions:(options)->
    for key,option of options
      option.title = key
      option
    
  handleClicked:(index,event)=>
    if @getOptions().navigable
      super

  createTabs:(forms)->
    forms.forEach (formData,index)=>
      @addPane tab = new KDTabPaneView name : formData.title

      oldCallback = formData.callback
      formData.callback = (formElements)=>
        @showNextPane() if @getOptions().goToNextFormOnSubmit
        oldCallback? formElements
        if index is forms.length - 1
          @fireFinalCallback()

      @createForm formData,tab

  createForm:(formData,parentTab)->
    parentTab.addSubView form = new KDFormViewWithFields formData
    @forms[formData.title] = parentTab.form = form
    return form

  getFinalData:->
    finalData = {}
    for pane in @panes
      finalData = $.extend pane.form.getData(),finalData
    finalData

  fireFinalCallback:->
    finalData = @getFinalData()
    @getOptions().callback? finalData
    
    

# new KDTabViewWithForms
#   callback              : (formOutput)-> log formOutput,"All Forms ::::::"
#   navigable          : yes
#   forms                 :
#     "My first form"     :
#       buttons           :
#         Next            :
#           title         : "Next"
#           style         : "modal-clean-gray"
#           type          : "submit"
#       # callback          : (formOutput)-> log formOutput,"Form 1 ::::::"
#       fields            :
#         Hiko            :
#           label         : "Title:"
#           type          : "text"
#           name          : "hiko"
#           placeholder   : "give a name to your topic..."
#           validate      :
#             rules       :
#               required  : yes
#             messages    :
#               required  : "topic name is required!"
#         Zikko           :          
#           label         : "Zikkko"
#           type          : "textarea"
#           name          : "zikko"
#           placeholder   : "give something else to your topic..."
#           nextElement   :
#             lulu        :
#               type        : "text"
#               name        : "lulu"
#               placeholder : "lulu..."
#     "My Second Form"    :
#       buttons           :  
#         Submit          :
#           title         : "Submit"
#           style         : "modal-clean-gray"
#           type          : "submit"
#         Reset           :
#           title         : "Reset"
#           style         : "modal-clean-red"
#           type          : "reset"
#       # callback          : (formOutput)-> log formOutput,"Form 2 ::::::"
#       fields            :  
#         Hoho            :           
#           label         : "Hoho:"
#           type          : "text"
#           name          : "title"
#           placeholder   : "give a gogo..."
#           validate      :
#             rules       :
#               required  : yes
#             messages    :
#               required  : "topic name is required!"