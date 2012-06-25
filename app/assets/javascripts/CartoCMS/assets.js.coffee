jQuery ($)->

  $("#multi-file_upload").fileupload
    destroy: (event, data)->
      triggerObject = $(event.target)
      message = triggerObject.data('confirm-message') || triggerObject.parent().data('confirm-message')
      if confirm(message)
        $.blueimpUI.fileupload.prototype
        .options.destroy.call(@, event, data);

  if $('#multi-file_upload').length
    $.getJSON $("#multi-file_upload").prop("action"), (files) ->
      fu = $("#multi-file_upload").data("fileupload")
      template = undefined
      fu._adjustMaxNumberOfFiles -files.length
      template = fu._renderDownload(files).appendTo($("#multi-file_upload .files"))
      fu._reflow = fu._transition and template.length and template[0].offsetWidth
      template.addClass "in"
      $("#loading").remove()


  $("#single-file_upload").fileupload
    destroy: (event, data)->
      triggerObject = $(event.target)
      message = triggerObject.data('confirm-message') || triggerObject.parent().data('confirm-message')
      if confirm(message)
        $.blueimpUI.fileupload.prototype
        .options.destroy.call(@, event, data)
    dropZone: $('#dropzone')
    maxNumberOfFiles: 1
    previewMaxWidth:  245
    previewMaxHeight: 245

  if $('#dropzone').length
    # Dropzone Behavior
    $(document).bind "dragover", (event) ->
      dropZone = $("#dropzone")
      timeout  = window.dropZoneTimeout
      unless timeout
        dropZone.addClass "in"
      else
        clearTimeout timeout
      if event.target is dropZone[0]
        dropZone.addClass "hover"
      else
        dropZone.removeClass "hover"
      window.dropZoneTimeout = setTimeout(->
        window.dropZoneTimeout = null
        dropZone.removeClass "in hover"
      , 100)

    # Prevent Drag & Drop Default
    $(document).bind 'drop dragover', (event)->
      event.preventDefault()

    # Remove Dropzone Text
    $("#single-file_upload").bind 'fileuploaddrop', (event, data)->
      $("#dropzone").removeClass "empty"

    # Ajax Delete
    $('div.edit#content').on 'ajax:success', 'a[data-method="delete"]', ->
      $(@).closest('figure').fadeOut ->
        $("#dropzone").addClass "empty"

    $('#dropzone').hover(
      -> $('.hover_links').fadeIn(),
      -> $('.hover_links').fadeOut()
    )

  # Edit button hover state.
  $('div.index#content').on 'mouseenter', 'li.template-download div.preview', ->
    $(@).find('.hover_links').fadeIn()

  $('div.index#content').on 'mouseleave', 'li.template-download div.preview', ->
    $(@).find('.hover_links').fadeOut()
