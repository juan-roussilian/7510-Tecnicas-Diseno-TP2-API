require_relative 'gestor_de_saldo'
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
    # posible refacto alterar el gestor de saldo para que posea el salso
    # y cambiar el atributo saldo por un metodo
    gestor = GestorDeSaldo.new
    @saldo = gestor.cargar_saldo(@saldo, cantidad)
    gestor.actualizar_saldo(self)
    # @saldo += cantidad if cantidad.positive?
  end
end
