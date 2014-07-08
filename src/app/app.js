// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
    return $('form').submit(function(e) {
      var $error_email, $error_localy, $error_message, $error_name, $error_phone, $notification, email, localy, message, name, phone, valid;
      name = $(this).find("input[name='name']").val().trim();
      $error_name = $(this).find("p[data-error='name']");
      localy = $(this).find("input[name='localy']").val().trim();
      $error_localy = $(this).find("p[data-error='localy']");
      email = $(this).find("input[name='email']").val().trim();
      $error_email = $(this).find("p[data-error='email']");
      phone = $(this).find("input[name='phone']").val().trim();
      $error_phone = $(this).find("p[data-error='phone']");
      message = $(this).find("textarea[name='message']").val().trim();
      $error_message = $(this).find("p[data-error='message']");
      $notification = $(this).find("p[data-role='notification']");
      valid = function() {
        var is_valid;
        is_valid = true;
        if (!name) {
          $error_name.html('El nombre es requerido.');
          is_valid = false;
        } else {
          $error_name.html('');
        }
        if (!localy) {
          $error_localy.html('La localidad es requerida.');
          is_valid = false;
        } else {
          $error_localy.html('');
        }
        if (!email && !phone) {
          $error_email.html('Necesitamos un correo electrónico o teléfono para poder comunicarnos con vos.');
          is_valid = false;
        } else {
          if (email && /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(email) === false) {
            $error_email.html('El correo electrónico no es valido, por favor verifícalo.');
            is_valid = false;
          } else {
            $error_email.html('');
          }
        }
        if (!message) {
          $error_message.html('El mensaje es requerido');
          is_valid = false;
        } else {
          $error_message.html('');
        }
        return is_valid;
      };
      if (valid()) {
        console.log('form is valid');
        $.ajax({
          type: 'POST',
          url: 'proxy' + '.php',
          data: {
            'c-name': name,
            'c-locality': localy,
            'c-email': email,
            'c-phone': phone,
            'c-message': message
          },
          error: function(jqXHR, textStatus, errorThrown) {
            $notification.html('Lo sentimos, no hemos podido enviar tu mensaje. Intentalo más tarde.');
            return console.error('SEND ERROR');
          },
          success: function(data, textStatus, jqXHR) {
            $notification.html('¡Muchas gracias por tu mensaje, pronto estaremos en contacto!');
            return console.error('SEND SUCCESS');
          }
        });
      }
      $('form').each(function() {
        return this.reset();
      });
      return e.preventDefault();
    });
  });

}).call(this);