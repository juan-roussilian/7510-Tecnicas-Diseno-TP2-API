class GestorDeSaldo
  attr_reader :saldo

  def initialize(propietario)
    @propietario = propietario
    @saldo = 0
  end

  def cargar_saldo(cantidad)
    carga_posible(cantidad)

    @saldo += cantidad
    actualizar_saldo
  end

  def transferir(otro_usuario, cantidad)
    transferencia_posible(cantidad)

    @saldo -= cantidad
    otro_usuario.cargar_saldo(cantidad)
    actualizar_saldo
  end

  private

  def carga_posible(cantidad)
    nombre = @propietario.nil? ? 'test' : @propietario.nombre
    raise CargaNegativa.new(nombre, cantidad) unless cantidad.positive? || cantidad.zero?
  end

  def actualizar_saldo
    RepositorioUsuarios.new.save(@propietario) unless @propietario.nil? || @propietario.id.nil?
  end

  def transferencia_posible(cantidad)
    nombre = @propietario.nil? ? 'test' : @propietario.nombre
    raise SaldoInsuficiente.new(self.class, nombre) unless cantidad <= @saldo && cantidad.positive?
  end
end

class SaldoInsuficiente < StandardError
  def initialize(class_name, id)
    @class_name = class_name
    @id = id
    super("En #{@class_name} con el nombre #{@id} no tiene saldo suficiente")
  end
end

class CargaNegativa < StandardError
  def initialize(nombre, carga)
    @nombre = nombre
    @carga = carga
    super("#{@nombre} intento cargar #{@carga} negativos")
  end
end
