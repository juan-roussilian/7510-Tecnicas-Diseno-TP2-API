require 'rubygems'
require 'net/smtp'
require 'pony'

class EMail
  REMITENTE_EMAIL = 'from@example.com'.freeze
  DESTINATARIO_EMAIL = 'to@example.com'.freeze
  HOST = 'sandbox.smtp.mailtrap.io'.freeze
  PORT = 2525 # 25 or 465 or 587 or 2525
  USERNAME = '27d7476ac2888a'.freeze
  # PASSWORD
  AUTH = :PLAIN # PLAIN, LOGIN and CRAM-MD5

  ASUNTO = 'Movimiento realizado'.freeze

  def enviar_correo(mensaje_base, destinatario = DESTINATARIO_EMAIL)
    mensaje = procesado_de_mensaje(mensaje_base, destinatario)
    enviar_email(mensaje, destinatario)
  end

  private

  def procesado_de_mensaje(mensaje_base, destinatario)
    hoy = Date.today # pasar a RFC 2822
    ["From: Private Person <#{REMITENTE_EMAIL}>",
     "To: A User <#{destinatario}>",
     "Date: #{hoy}",
     # "Subject: #{ASUNTO}",
     '',
     mensaje_base].join("\r\n")
  end

  def enviar_email(mensaje, destinatario)
    Pony.options = { from: REMITENTE_EMAIL, via: :smtp, via_options: { host: HOST } }
    Pony.mail({
                to: destinatario,
                subject: ASUNTO,
                body: mensaje,
                via: :smtp,
                via_options: {
                  address: HOST,
                  port: PORT,
                  user_name: USERNAME,
                  password: PASSWORD,
                  authentication: AUTH, # :plain, :login, :cram_md5, no auth by default
                  domain: 'localhost.localdomain' # the HELO domain provided by the client to the server
                }
              })
    # todavia sigue con los datos de test refactor
    # Net::SMTP.start(HOST,
    #                 PORT,
    #                 HOST,
    #                 USERNAME,
    #                 PASSWORD,
    #                 AUTH) do |smtp|
    #   smtp.send_message mensaje,
    #                     REMITENTE_EMAIL,
    #                     destinatario
    # end
  end
end
