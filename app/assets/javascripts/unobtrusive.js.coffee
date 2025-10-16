
# Initialize global variables
$.appVariables = {} unless $.appVariables?

window.app =
  pathPrefix: ->
    # Path prefix no longer needed in Rails 4 asset pipeline
    $.appVariables.path_prefix = ''

  setupSearch: ->
    search_form = $ '<form/>', {
      action: '/disenos.js',
      id: 'search_form',
      submit: (e) ->
        e.preventDefault()
        $.get $(@).attr('action'), $(@).serialize(), null, "script" if ($ '#search').val().length > 3
    }

    search_label = $ '<label/>', {id: 'search_label', html: 'Buscar: '}
      .appendTo(search_form)
    search_box = $ '<input/>', {id: 'search', type: 'text', name: 'search'}
      .appendTo(search_form)

    search_div = $ "<div/>", {id: "top-search", html: search_form}
      .appendTo($('#top-bar .float-right'))
    
  setupAjaxCallbacks: ->
    busy = $ 'div', {id: "busy", html: "Carcando...", style: "display: none;"}
      .appendTo($("body"))
      
    # Register Ajax callback for stopt and start
    ($ 'body').ajaxStart -> ($ '#busy').show()
    ($ 'body').ajaxStop -> ($ '#busy').fadeOut()
  
  editDisenoSetup: ->
    add_hilo = $ '<p/>', { html: $ '<a/>', { id: "add_hilo", href: '', html: "Agregar Hilo", click: (e) ->
          e.preventDefault() 
          newHilo = ($ '.pick_color').last().clone()
          newHilo.show()
          newHilo.find('input[type=checkbox]').removeAttr('checked')
          newHilo.find('input[type=hidden]').remove()
          newHilo.find('.color').hide()
          inputEliments = newHilo.find('select, input, label')
          console.log inputEliments
          updateIds inputEliments
          ($ '#hilos_select').append(newHilo)
          newHilo.find('input').first().focus()}}
          
    ($ '#hilos').append(add_hilo)
    ($ document).delegate 'input[type=checkbox]', 'click', ->
      if ($ @).prev('input').length != 0
        ($ @).parent().fadeOut()
      else
        ($ @).parent().fadeOut ->
          ($ @).remove()
    
  hideColors: -> 
    color.hide() if color.value == "" for color in ($ '.color')

  marcaSlecetSetup: ->
    ($ '.color').hide()
    ($ document).delegate '.marca', 'change', ->  marcaSelected(this)
      
  editHilosSetup: ->
    add_color_link = $ '<p/>', {
      html: $ '<a/>', {
        id: "add_color_link",
        html: "Add Color",
        href: '',
        click: (e) ->
          e.preventDefault()
          newColor = ($ '.color_row').last().clone()
          newColor.show()
          newColor.find('input[type=checkbox]').removeAttr('checked')
          newColor.find('input[type="text"]').val("")
          newColor.toggleClass("odd even")
          newColor.find('input[type=hidden]').remove()
          inputEliments = newColor.find('input')
          updateIds inputEliments
          hex_color_input = newColor.find('.hex_color')
          colorPickerSetup hex_color_input
          ($ hex_color_input).parent().css('backgroundColor', '')
          ($ '#colors').append(newColor)
          newColor.find('input').first().focus()}}
    
    ($ '#add_color').append(add_color_link)
    ($ '#submit_button').hide()
    ($ document).delegate 'input[type=checkbox]', 'click', ->
      if ($ @).prev().length != 0
        ($ @).parent().parent().fadeOut()
      else
        ($ @).parent().parent().fadeOut ->
          ($ @).remove()
    
    ($ '.hex_color').each (i) ->
      colorPickerSetup(@)
  
  emailSetup: ->
    email_link = $ '<p/>', {
      html: $ '<a/>', {
        href: '',
        id: 'email_image',
        html: 'Email Image',
        click: (e) ->
          e.preventDefault()
          ($ '#notice').text('')
          ($ '#error').text('')
          ($ '#email').show()
          ($ '#email_cancel').show()
          ($ '#email_submit').show()
          ($ '#email_subject').attr('disabled', '').val('')
          ($ '#email_body').attr('disabled', '').val('')}}

    ($ '#images').append(email_link)
    ($ '#email_submit').click (e) ->
      @hide()
      ($ '#email_cancel').hide()
    
    ($ '#email_cancel').click (e) ->
      e.preventDefault()
      ($ '#email').hide()
      
  getColors: ->
    $.getJSON '/colores.json', (data) -> 
      $.appVariables.colors = data
    
    
updateIds = (elements) ->
    elements.each (i, el) ->
      attr_name = ($ el).attr('name')
      attr_id = ($ el).attr('id')
      attr_for = ($ el).attr('for')
      ($ el).attr('name', updateAttr(attr_name)) if attr_name
      ($ el).attr('id', updateAttr(attr_id)) if attr_id
      ($ el).attr('for', updateAttr(attr_for)) if attr_for

updateAttr = (text) ->
  record_val = text.match(/\d/g).toString().replace(/,/g,'')
  text.replace(record_val,parseInt(record_val) + 1)
  
colorPickerSetup = (textbox) ->
  ($ textbox).ColorPicker
    onShow: (colpkr) ->
      $(colpkr).fadeIn(500)
      return false
    onHide: (colpkr) ->
      $(colpkr).fadeOut(500)
      return false
    onChange: (hsb, hex, rgb, el) ->
      el.parent().css('backgroundColor', '#' + hex)
    onSubmit: (hsb, hex, rgb, el) ->
      el.val(hex)
      el.ColorPickerHide()
    onBeforeShow: (cal, el) ->
      el.ColorPickerSetColor(this.value)
  
marcaSelected = (eliment) ->
  marca_id = parseInt ($ eliment).val()
  select = ($ eliment).nextAll('select')
  # Remove all old options
  ($ eliment).nextAll('select').children().remove()
  for color in $.appVariables.color
    if (color.marca_id == marca_id) 
      select.append("<option value='#{color.id}'>#{color.nombre}</option>")
  if select.children().length == 0 then select.hide() else select.show()
  
pathLocation = (path) ->
  location = path.toLowerCase().split('#')
  contoller = location[0]
  actions = location[1].split('/')
  match = false
  for action in actions
    match = $('body').data('controller') == "#{contoller}##{action}" unless match == true
  match

jQuery ->
  # Global/Always load
  if window.app?
    window.app.pathPrefix()
    window.app.setupAjaxCallbacks()
  else
    console.error('window.app is not defined')

  # Hilos#edit/new
  window.app.editHilosSetup() if window.app? and pathLocation("hilos#new/edit")

  # Disenos#edit/new
  if window.app? and pathLocation("disenos#edit/new")
    window.app.getColors()
    window.app.marcaSlecetSetup()
    window.app.editDisenoSetup()

  # Disenos#show
  window.app.emailSetup() if window.app? and pathLocation("disenos#show")

  # Disenos#index - check for the search div or use data attribute
  if window.app?
    bodyController = $('body').data('controller')
    if bodyController == "disenos#index" || $('.search').length > 0
      window.app.setupSearch()
      ($ '#timeline').load "/javascripts/timeline"
  