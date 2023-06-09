class GestorDeSaldo
  attr_reader :saldo

  def initialize(propietario)
    @propietario = propietario
    @saldo = 0
  end

  def cargar_saldo(cantidad)
    @saldo += cantidad if cantidad.positive?
    actualizar_saldo
  end

  def transferir(otro_usuario, cantidad)
    transferencia_posible(cantidad)

    @saldo -= cantidad
    otro_usuario.cargar_saldo(cantidad)
    actualizar_saldo
  end

  private

  def actualizar_saldo
    RepositorioUsuarios.new.save(@propietario) unless @propietario.nil? || @propietario.id.nil?
  end

  def transferencia_posible(cantidad)
    nombre = if @propietario.nil?
               'test'
             else
               @propietario.nombre
             end
    raise SaldoInsuficiente.new(self.class, nombre) unless cantidad <= @saldo && cantidad.positive?
  end
end

class SaldoInsuficiente < StandardError
  def initialize(class_name, id)
    @class_name = class_name
    @id = id
    super("Object #{@class_name} with id #{@id} not found")
  end
end
