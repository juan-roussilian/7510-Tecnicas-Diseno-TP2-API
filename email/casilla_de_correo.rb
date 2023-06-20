require 'rubygems'
require 'net/smtp'
require 'pony'
require 'byebug'

class CasillaCorreo
  REMITENTE_EMAIL = 'tokiomemo2@gmail.com'.freeze
  HOST = 'smtp.gmail.com'.freeze
  PORT = '587'.freeze
  USERNAME = 'tokiomemo2@gmail.com'.freeze
  PASSWORD = 'lonuhrcabigzvztw'.freeze
  AUTH = :plain

  ASUNTO = 'Movimiento realizado'.freeze

  LOCAL_VIA = :file
  LOCAL_CONFIG = {
    location: 'tmp/testmail'
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

  def initialize(test_mode)
    @test_mode = test_mode
  end

  def enviar_correo(mensaje_base, destinatario)
    mensaje = procesado_de_mensaje(mensaje_base, destinatario)
    if @test_mode
      enviar_email(mensaje, destinatario, LOCAL_VIA, LOCAL_CONFIG)
    else
      enviar_email(mensaje, destinatario, SMTP_VIA, SMTP_CONFIG)
    end
  end

  def enviar_correo_transferencia(destinatario, nombre, monto)
    mensaje_base = "Se ha transferido #{monto} a #{nombre} con exito."
    mensaje = procesado_de_mensaje(mensaje_base, destinatario)
    if @test_mode
      enviar_email(mensaje, destinatario, LOCAL_VIA, LOCAL_CONFIG)
    else
      enviar_email(mensaje, destinatario, SMTP_VIA, SMTP_CONFIG)
    end
  end

  private

  def procesado_de_mensaje(mensaje_base, destinatario)
    hoy = Date.today
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
