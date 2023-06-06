require_relative 'gestor_de_saldo'
class Usuario
  attr_reader :nombre, :email, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, email, id = nil)
    @nombre = nombre
    @email = email
    @id = id
    @saldo = GestorDeSaldo.new(self)
  end

  def cargar_saldo(cantidad)
    @saldo.cargar_saldo(cantidad)
  end

  def saldo
    @saldo.saldo
  end
end
