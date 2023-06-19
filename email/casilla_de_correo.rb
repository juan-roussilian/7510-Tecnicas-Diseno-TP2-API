require 'rubygems'
require 'net/smtp'
require 'pony'

class EMail
  REMITENTE_EMAIL = 'tokiomemo2@gmail.com'.freeze
  DESTINATARIO_EMAIL = 'to@example.com'.freeze
  HOST = 'smtp.gmail.com'.freeze
  PORT = '587'.freeze # 25 or 465 or 587 or 2525
  USERNAME = 'tokiomemo2@gmail.com'.freeze
  PASSWORD = 'lonuhrcabigzvztw'.freeze
  AUTH = :plain # PLAIN, LOGIN and CRAM-MD5

  ASUNTO = 'Movimiento realizado'.freeze

  LOCAL_VIA = :file
  LOCAL_CONFIG = {
    location: 'testmail/'
  }.freeze
  SMTP_VIA = :smtp
  SMTP_CONFIG = {
    address: HOST,
    port: PORT,
    enable_starttls_auto: true,
    user_name: USERNAME,
    password: PASSWORD,
    authentication: AUTH,
    domain: 'localhost.localdomain'
  }.freeze

  def enviar_correo(mensaje_base, destinatario = DESTINATARIO_EMAIL, test: false)
    mensaje = procesado_de_mensaje(mensaje_base, destinatario)
    if test
      enviar_email(mensaje, destinatario, LOCAL_VIA, LOCAL_CONFIG)
    else
      enviar_email(mensaje, destinatario, SMTP_VIA, SMTP_CONFIG)
    end
  end

  private

  def procesado_de_mensaje(mensaje_base, destinatario)
    hoy = Date.today # pasar a RFC 2822
    ["From: #{REMITENTE_EMAIL}",
     "To: #{destinatario}",
     "Date: #{hoy}",
     '',
     mensaje_base].join("\r\n")
  end

  def enviar_email(mensaje, destinatario, via, config)
    Pony.mail({
                from: REMITENTE_EMAIL,
                to: destinatario,
                subject: ASUNTO,
                body: mensaje,
                via:,
                via_options: config
              })
  end
end
