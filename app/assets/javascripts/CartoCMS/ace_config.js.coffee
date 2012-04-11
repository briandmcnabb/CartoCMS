jQuery ($)->
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