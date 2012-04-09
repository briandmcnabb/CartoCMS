jQuery ($)->

  # Update Filepath
  $('div#content').on 'submit', 'input#update_filepath', (event)->
    event.preventDefault()
    $.rails.handleRemote $('div#content form>div :input, div#virtual-filepath-inputs :input')


  # Toggle Filepath Inputs
  $('div#content').on 'click', 'a#edit-filepath', (event)->
    event.preventDefault()
    $('#virtual-filepath-inputs').slideToggle()


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

  # ACE
  textarea = $('#editor').prevUntil('div.ace', 'textarea')
  mode     = textarea.data('ace-mode')
  theme    = textarea.data('ace-theme')

  editor   = ace.edit("editor")
  session  = editor.getSession()
  renderer = editor.renderer
  mode     = require("ace/mode/#{mode}").Mode

  editor.setTheme "ace/theme/#{theme}"
  renderer.setShowPrintMargin false
  renderer.setHScrollBarAlwaysVisible false
  session.setMode new mode()
  session.setTabSize 2
  session.setUseSoftTabs true
  session.setFoldStyle "markbeginend"
  session.setValue textarea.val()
  session.on "change", ->
    textarea.val session.getValue()
  console.log session.getLength()





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