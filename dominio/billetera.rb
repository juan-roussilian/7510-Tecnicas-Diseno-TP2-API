class Billetera
  attr_reader :saldo

  def initialize(propietario, repositorio = nil)
    raise SinPropietario if propietario.nil?

    @propietario = propietario
    @saldo = 0
    @repositorio = repositorio
  end

  def repositorio(repositorio)
    @repositorio = repositorio
  end

  def cargar_saldo(cantidad)
    carga_posible(cantidad)

    @saldo += cantidad
    actualizar_saldo unless @repositorio.nil?
  end

  def transferir(otro_usuario, cantidad)
    transferencia_posible(cantidad)

    @saldo -= cantidad
    otro_usuario.cargar_saldo(cantidad)
    actualizar_saldo unless @repositorio.nil?
  end

  private

  def carga_posible(cantidad)
    raise CargaNegativa.new(@propietario.nombre, cantidad) unless cantidad.positive? || cantidad.zero?
  end

  def actualizar_saldo
    @repositorio.save(@propietario) unless @propietario.nil? || @propietario.id.nil?
  end

  def transferencia_posible(cantidad)
    raise SaldoInsuficiente.new(self.class, @propietario.nombre) unless cantidad <= @saldo && cantidad.positive?
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

class SinPropietario < StandardError
  def initialize
    super('Creacion de billetera sin propietario')
  end
end
