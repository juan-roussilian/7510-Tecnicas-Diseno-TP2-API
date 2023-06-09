require_relative 'billetera'
class Usuario
  attr_reader :nombre, :email, :updated_on, :created_on, :telegram_id, :telegram_username
  attr_accessor :id

  def initialize(nombre, email, telegram_id, telegram_username, id = nil)
    @nombre = nombre
    @email = email
    @id = id
    @telegram_id = telegram_id
    @telegram_username = telegram_username
    @saldo = Billetera.new(self)
  end

  def cargar_saldo(cantidad)
    @saldo.cargar_saldo(cantidad)
  end

  def saldo
    @saldo.saldo
  end

  def transferir(otro_usuario, cantidad)
    @saldo.transferir(otro_usuario, cantidad)
  end
end
