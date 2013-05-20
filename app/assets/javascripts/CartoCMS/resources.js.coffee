jQuery ->

  # Ajax Delete
  $('div.index#content').on 'ajax:success', 'a[data-method="delete"]', ->
    $(@).closest('li').fadeOut()
    $(@).closest('tr').fadeOut()

  # Assets: Add Files
  $('div.panel header').on 'click', 'a#add_files', (event)->
    event.preventDefault()
    $('input#asset_asset_path').click()


  # Boolean Toggler
  $('div#content').on 'change', '.boolean_toggler input', ->
    checkbox_state = $(@).is ':checked'
    $(@).siblings('label').text checkbox_state


  # Datepicker
   $('div#content').on 'focus', 'input.date', ->
     $(@).datepicker
       dateFormat: 'mm/dd/y'


  # jQuery Collapse
  $(".details").collapse
    head: "label.summary"
    group: ".hidden-content"
    show: ->
      @slideToggle()
    hide: ->
      @slideToggle()


  # Positionable
  $('ul#positionable').sortable
    axis: 'y'
    handle: '.handle'
    placeholder: 'placeholder'
    update: ->
      $.post($(this).data('position-url'), $(this).sortable('serialize'))

