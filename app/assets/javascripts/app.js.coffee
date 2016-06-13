$ ->
  $('.single-uploader').on 'click', '.image_thumb', (e)->
    e.preventDefault()
    $('.upload_form .image-file-field').click();

  $('.upload_form').on 'change', '.image-file-field', (e)->
    loader.build('.img-box')
    $(this).parents('form').submit()

  $('.single-uploader').on 'click', '.edit', (e) ->
    e.preventDefault()
    $('.edit-image-modal-lg').modal('show')

  $('.submit_on_enter').on 'keydown', (e)->
    if e.keyCode == 13
      $(this).closest("form").submit();
      return false

  $('.currency-form form input').on 'keyup', ->
    $(this)
      .closest('form')
      .find('.submit-btn')
      .addClass('visible')