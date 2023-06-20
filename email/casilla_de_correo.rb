require 'rubygems'
require 'net/smtp'
require 'pony'

class CasillaCorreo
  def initialize(test_mode)
    @test_mode = test_mode

    @asunto = 'Movimiento realizado'.freeze

    @local_via = :file
    @local_config = {
      location: 'tmp/testmail'
    }
    @direccion_mail = ENV['DIRECION_MAILER'] || 'tokiomemo2@gmail.com'
    @smtp_via = :smtp
    @smtp_config = {
      address: ENV['HOST_MAILER'],
      port: ENV['PUERTO_MAILER'],
      enable_starttls_auto: true,
      user_name: @direccion_mail,
      password: ENV['CONTRASENA_MAILER'],
      authentication: :plain,
      domain: ENV['MAILING_DOMAIN']
    }
  end

  def enviar_correo(mensaje_base, destinatario)
    mensaje = procesado_de_mensaje(mensaje_base, destinatario)
    if @test_mode
      enviar_email(mensaje, destinatario, @local_via, @local_config)
    else
      enviar_email(mensaje, destinatario, @smtp_via, @smtp_config)
    end
  end

  def enviar_correo_transferencia(destinatario, nombre, monto)
    mensaje_base = "Se ha transferido #{monto} a #{nombre} con exito."
    mensaje = procesado_de_mensaje(mensaje_base, destinatario)
    if @test_mode
      enviar_email(mensaje, destinatario, @local_via, @local_config)
    else
      enviar_email(mensaje, destinatario, @smtp_via, @smtp_config)
    end
  end

  private

  def procesado_de_mensaje(mensaje_base, destinatario)
    hoy = Date.today
    ["From: #{@direccion_mail}",
     "To: #{destinatario}",
     "Date: #{hoy}",
     '',
     mensaje_base].join("\r\n")
  end

  def enviar_email(mensaje, destinatario, via, config)
    Pony.mail({
                from: @direccion_mail,
                to: destinatario,
                subject: @asunto,
                body: mensaje,
                via:,
                via_options: config
              })
  end
end
