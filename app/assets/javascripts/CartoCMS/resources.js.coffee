jQuery ->

  # Ajax Delete
  $('div#content').on 'ajax:success', 'a[data-method="delete"]', ->
    $(@).closest('tr').fadeOut()


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
     $.post($(this).data('position_url'), $(this).sortable('serialize'))