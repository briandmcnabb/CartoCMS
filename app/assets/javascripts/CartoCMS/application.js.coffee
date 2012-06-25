# Flash Messages
$('aside.flash_message').delay(5000).fadeToggle 1000, 'easeInOutCubic', ->
    $(@).remove()

$('section#top-level.container').on 'ajaxSuccess', ->
  $('aside.flash_message').delay(5000).fadeToggle 1000, 'easeInOutCubic', ->
    $(@).remove()

# Slide fadeToggle
$('div#content').on 'click', 'a.visibility-toggler', (event)->
    event.preventDefault()
    id = $(@).data('target')
    console.log id
    $(id).slideToggle()