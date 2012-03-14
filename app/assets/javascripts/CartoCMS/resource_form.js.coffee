jQuery ->

  # Datepicker
  $('div#content').on 'focus', 'input.date', ->
    $(@).datepicker
      dateFormat: 'mm/dd/y'


  # Boolean Toggler
  $('div#content').on 'change', '.boolean_toggler input', ->
    checkbox_state = $(@).is ':checked'
    $(@).siblings('label').text checkbox_state


  # Set Publish Date and Time with Publish Now
  $('div#content').on 'click', 'input[type="submit"]#publish', (event)->
    event.preventDefault()
    currentDatetime = new Date()
    date = $('input[type="text"].date')
    time = $('input[type="text"].time')
    date.val currentDatetime.strftime(date.data('parsing-pattern'))
    time.val currentDatetime.strftime(time.data('parsing-pattern'))