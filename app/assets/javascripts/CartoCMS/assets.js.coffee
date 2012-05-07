jQuery ($)->
  $("#fileupload").fileupload
    destroy: (e, data)->
      triggerObject = $(e.target)
      message = triggerObject.data('confirm-message') || triggerObject.parent().data('confirm-message')
      if confirm(message)
        $.blueimpUI.fileupload.prototype
        .options.destroy.call(this, e, data);

  if $('#fileupload').length
    $.getJSON $("#fileupload").prop("action"), (files) ->
      fu = $("#fileupload").data("fileupload")
      template = undefined
      fu._adjustMaxNumberOfFiles -files.length
      template = fu._renderDownload(files).appendTo($("#fileupload .files"))
      fu._reflow = fu._transition and template.length and template[0].offsetWidth
      template.addClass "in"
      $("#loading").remove()