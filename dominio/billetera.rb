require_relative './movimiento_carga'
require_relative './movimiento_transferencia'
require_relative './movimiento_pago_de_gasto'

class Billetera
  attr_reader :saldo

  def initialize(propietario)
    raise SinPropietario if propietario.nil?

    @propietario = propietario
    @saldo = 0
  end

  def cargar_saldo(cantidad, repositorio_usuarios, repositorio_movimientos = nil)
    carga_posible(cantidad)

    @saldo += cantidad
    actualizar_saldo(repositorio_usuarios)
    repositorio_movimientos&.save(MovimientoCarga.new(@propietario, cantidad))
  end

  def transferir(otro_usuario, cantidad, repositorio_usuarios, repositorio_movimientos = nil)
    transferencia_posible(cantidad)

    @saldo -= cantidad
    otro_usuario.cargar_saldo(cantidad, repositorio_usuarios)
    actualizar_saldo(repositorio_usuarios)
    repositorio_movimientos&.save(MovimientoTransferencia.new(@propietario, cantidad,
                                                              otro_usuario))
  end

  private

  def carga_posible(cantidad)
    raise CargaNegativa.new(@propietario.nombre, cantidad) unless cantidad.positive? || cantidad.zero?
  end

  def actualizar_saldo(repositorio_usuarios)
    repositorio_usuarios.save(@propietario) unless @propietario.nil? || @propietario.id.nil?
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
