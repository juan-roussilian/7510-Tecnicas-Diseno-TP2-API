require_relative 'billetera'
class Usuario
  attr_reader :nombre, :email, :updated_on, :created_on, :telegram_id, :telegram_username
  attr_accessor :id

  CARACTER_SEPARADOR_EMAIL = '@'.freeze
  SECCIONES_SEPARADOR_EMAIL = 2
  CARACTER_SEPARADOR_DOMINIO = '.'.freeze
  SECCIONES_SEPARADOR_DOMINIO = -1
  INICIO_DE_MENSAJE_DE_TRANSFERENCIA = 'Se ha transferido '.freeze
  MEDIO_DE_MENSAJE_DE_TRANSFERENCIA = ' a '.freeze
  FIN_DE_MENSAJE_DE_TRANSFERENCIA = ' con exito.'.freeze

  def initialize(nombre, email, telegram_id, telegram_username, id = nil)
    @nombre = nombre
    email_valido(email)
    @email = email
    @id = id
    @telegram_id = telegram_id
    @telegram_username = telegram_username
    @saldo = Billetera.new(self)
  end

  def repositorio(repositorio)
    @saldo.repositorio(repositorio)
  end

  def cargar_saldo(cantidad)
    @saldo.cargar_saldo(cantidad)
  end

  def saldo
    @saldo.saldo
  end

  def transferir(otro_usuario, cantidad, casilla_de_email = nil)
    @saldo.transferir(otro_usuario, cantidad)
    casilla_de_email&.enviar_correo(mensaje_de_transferencia(otro_usuario.nombre, cantidad),
                                    @email)
  end

  private

  def email_valido(mail)
    secciones = mail.split(CARACTER_SEPARADOR_EMAIL, SECCIONES_SEPARADOR_EMAIL)
    raise EmailInvalido.new(@nombre, mail) unless secciones.count == 2

    secciones_validas(secciones, mail)
    dominios_validos(secciones[1], mail)
  end

  def secciones_validas(secciones, mail)
    raise EmailInvalido.new(@nombre, mail) if secciones[0].empty? || secciones[1].empty?
  end

  def dominios_validos(dominio, mail)
    dominios = dominio.split(CARACTER_SEPARADOR_DOMINIO, SECCIONES_SEPARADOR_DOMINIO)
    raise EmailInvalido.new(@nombre, mail) if dominios.count == 1

    raise EmailInvalido.new(@nombre, mail) unless dominios.find_index('').nil?
  end

  def mensaje_de_transferencia(nombre, monto)
    INICIO_DE_MENSAJE_DE_TRANSFERENCIA + monto +
      MEDIO_DE_MENSAJE_DE_TRANSFERENCIA + nombre +
      FIN_DE_MENSAJE_DE_TRANSFERENCIA
  end
end

class EmailInvalido < StandardError
  def initialize(nombre, mail)
    @nombre = nombre
    @mail = mail
    super("El usuario #{@nombre} tiene mail #{@mail} que es invalido")
  end
end
