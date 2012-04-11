jQuery ($)->

  # Update Filepath
  $('div#content').on 'submit', 'input#update_filepath', (event)->
    event.preventDefault()
    $.rails.handleRemote $('div#content form>div :input, div#virtual-filepath-inputs :input')


  # FilepathWriter
  $(document).on 'ajaxSuccess ready', ->
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


  # Set Publish Date and Time with Publish Now
  $('div#content').on 'click', 'input[type="submit"]#publish', (event)->
    event.preventDefault()
    currentDatetime = new Date()
    date = $('input[type="text"].date')
    time = $('input[type="text"].time')
    date.val currentDatetime.strftime(date.data('parsing-pattern'))
    time.val currentDatetime.strftime(time.data('parsing-pattern'))




class FilepathWriter
  constructor: ->
    @updatePartializers()

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
