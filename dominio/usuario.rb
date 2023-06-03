class Usuario
  attr_reader :nombre, :email, :updated_on, :created_on, :saldo
  attr_accessor :id

  def initialize(nombre, email, id = nil)
    @nombre = nombre
    @email = email
    @id = id
    @saldo = 0
  end

  def cargar_saldo(cantidad)
    @saldo += cantidad if cantidad.positive?
  end
end
