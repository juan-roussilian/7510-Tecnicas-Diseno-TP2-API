require_relative 'gestor_de_saldo'
class Usuario
  attr_reader :nombre, :email, :updated_on, :created_on, :telegram_id
  attr_accessor :id

  def initialize(nombre, email,telegram_id, id = nil)
    @nombre = nombre
    @email = email
    @id = id
    @telegram_id = telegram_id
    @saldo = GestorDeSaldo.new(self)
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
