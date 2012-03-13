jQuery ->

  # Datepicker
  $('div#content').on 'ajaxSuccess', ->
    $('input.date').datepicker
      dateFormat: 'mm/dd/y'

  # Boolean Toggler
  $('div#content').on 'change', '.boolean_toggler input', ->
    checkbox_state = $(@).is ':checked'
    $(@).siblings('label').text checkbox_state

  # Toggle Filepath Inputs
  $('div#content').on 'click', 'a#edit-filepath', (event)->
    event.preventDefault()
    $('#virtual-filepath-inputs').slideToggle()

  # Set Publish Date and Time with Publish Now
  $('div#content').on 'click', 'input[type="submit"]#publish', (event)->
    event.preventDefault()
    currentDatetime = new Date()
    date = $('input[type="text"].date')
    time = $('input[type="text"].time')
    date.val currentDatetime.strftime(date.data('parsing-pattern'))
    time.val currentDatetime.strftime(time.data('parsing-pattern'))

  # FilepathWriter
  $('div#content').on 'ajaxSuccess', ->
    if $('#virtual-filepath').length
      filepath_writer =  new FilepathWriter()

      $('input.writer, select.writer').each ->
        filepath_writer.writeValue $(@)

      $('input[type="text"].writer').keyup ->
        filepath_writer.writeValue $(@)

      $('input[type="text"].writer, select.writer').change ->
        filepath_writer.writeValue $(@)

      $('input[type="checkbox"].writer').change ->
        filepath_writer.updatePartializers $(@)
        filepath_writer.writeValue $('input[type="text"].writer')


class FilepathWriter
  constructor: ->
    @updatePartializers


  writeValue: (input, id=input.attr('id'))=>
    value = input.val()
    $("span##{id}").text @partialize(value)


  partialize: (value)=>
    value.split(@splitter).join(@joiner)


  updatePartializers: (checkbox = $('input[type="checkbox"].writer'))=>
    partial = checkbox.is ':checked'
    if partial
      @splitter = '/'
      @joiner   = '/_'
    else
      @splitter = '/_'
      @joiner   = '/'