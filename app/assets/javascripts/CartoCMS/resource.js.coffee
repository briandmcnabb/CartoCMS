jQuery ->
  
  $('div#content').on 'ajax:success', 'a[data-method="delete"]', ->
    $(@).closest('tr').fadeOut()