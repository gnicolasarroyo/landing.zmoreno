$ ->
  $('form').submit (e) ->
    name           = $(@).find("input[name='name']").val().trim()
    $error_name    = $(@).find("p[data-error='name']")
    localy         = $(@).find("input[name='localy']").val().trim()
    $error_localy  = $(@).find("p[data-error='localy']")
    email          = $(@).find("input[name='email']").val().trim()
    $error_email   = $(@).find("p[data-error='email']")
    phone          = $(@).find("input[name='phone']").val().trim()
    $error_phone   = $(@).find("p[data-error='phone']")
    message        = $(@).find("textarea[name='message']").val().trim()
    $error_message = $(@).find("p[data-error='message']")
    $notification  = $(@).find("p[data-role='notification']")

    valid = ->
      is_valid = true
      if not name
        $error_name.html 'El nombre es requerido.'
        is_valid = false
      else
        $error_name.html ''
      if not localy
        $error_localy.html 'La localidad es requerida.'
        is_valid = false
      else
        $error_localy.html ''
      if not email and not phone
        $error_email.html 'Necesitamos un correo electrónico o teléfono para poder comunicarnos con vos.'
        is_valid = false
      else 
        if email and /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email) is false
          $error_email.html 'El correo electrónico no es valido, por favor verifícalo.'
          is_valid = false
        else 
          $error_email.html ''
      if not message
        $error_message.html 'El mensaje es requerido'
        is_valid = false
      else
        $error_message.html ''
      is_valid


    if valid()
      console.log 'form is valid'
      $.ajax
        type: 'POST' 
        url: 'proxy'+'.php'
        data:
          'c-name': name
          'c-locality': localy
          'c-email': email
          'c-phone': phone
          'c-message': message
        error: (jqXHR, textStatus, errorThrown) ->
          $notification.html 'Lo sentimos, no hemos podido enviar tu mensaje. Intentalo más tarde.'
          console.error 'SEND ERROR'
        success: (data, textStatus, jqXHR) ->
          $notification.html '¡Muchas gracias por tu mensaje, pronto estaremos en contacto!'
          console.error 'SEND SUCCESS'

    $('form').each ->
      @.reset()
    e.preventDefault()