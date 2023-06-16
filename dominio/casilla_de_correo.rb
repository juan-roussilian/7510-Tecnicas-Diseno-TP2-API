require 'rubygems'
require 'net/smtp'

class EMail
  REMITENTE_EMAIL = 'from@example.com'.freeze
  DESTINATARIO_EMAIL = 'to@example.com'.freeze
  # Host:
  #     sandbox.smtp.mailtrap.io
  # Port:
  #     25 or 465 or 587 or 2525
  # Username:
  #     27d7476ac2888a
  # Password:
  #     317d948a2ca9b1
  # Auth:
  #     PLAIN, LOGIN and CRAM-MD5
  # TLS:
  #     Optional (STARTTLS on all ports)
  HOST = 'sandbox.smtp.mailtrap.io'.freeze
  PORT = 2525 # 25 or 465 or 587 or 2525
  USERNAME = '27d7476ac2888a'.freeze
  # PASSWORD hay que colocarla en ENV
  AUTH = :PLAIN # PLAIN, LOGIN and CRAM-MD5

  def initialize
    enviar_email
  end

  private

  def enviar_email
    hoy = Date.today # pasar a RFC 2822
    mensaje = 'Hola esto es una prueba.'
    message = [
      "From: Private Person <#{REMITENTE_EMAIL}>",
      'To: A Test User <to@example.com>',
      "Date: #{hoy}",
      'Subject: Hello world!',
      '',
      mensaje
    ].join("\r\n")

    Net::SMTP.start(HOST,
                    PORT,
                    HOST,
                    USERNAME,
                    PASSWORD,
                    AUTH) do |smtp|
      smtp.send_message message,
                        REMITENTE_EMAIL,
                        DESTINATARIO_EMAIL
    end
  end
end
