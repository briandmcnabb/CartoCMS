$('div#content').on 'change', 'input[type="checkbox"]', (event)->
  event.preventDefault()
  $('form.update-admin').trigger 'submit'