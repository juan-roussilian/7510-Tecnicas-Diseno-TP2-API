require_relative './abstract_repository'
class RepositorioMovimientos < AbstractRepository
  TIPO_DE_MOV_CARGA = 'carga'.freeze
  TIPO_DE_MOV_TRANSFERENCIA = 'transferencia'.freeze
  TIPO_DE_MOV_PAGO_GASTO = 'pago'.freeze

  self.table_name = :movimientos
  self.model_class = 'Movimiento'

  def find_by_usuario_principal(id_usuario_principal)
    movimientos = []
    dataset.where(id_usuario_principal:).each do |movimiento|
      movimientos << load_object(movimiento)
    end
    movimientos
  end

  def find_by_usuario_secundario(id_usuario_secundario)
    movimiento_buscado = DB[:movimientos].where(id_usuario_secundario:).first
    raise ObjectNotFound.new('movimiento de usuario secundario', id_usuario_secundario) if movimiento_buscado.nil?

    load_object dataset.first(movimiento_buscado)
  end

  def find_by_gasto(id_gasto)
    movimientos = []
    dataset.where(id_gasto:).each do |movimiento|
      movimientos << load_object(movimiento)
    end
    movimientos
  end

  def find_by_tipo(tipo)
    movimientos = []
    dataset.where(tipo:).each do |movimiento|
      movimientos << load_object(movimiento)
    end
    movimientos
  end

  protected

  def cargar_movimiento_segun_tipo(a_hash, id, usuario, monto, fecha_creacion)
    case a_hash[:tipo]
    when TIPO_DE_MOV_TRANSFERENCIA
      cargar_movimiento_transferencia(a_hash, id, usuario, monto, fecha_creacion)
    when TIPO_DE_MOV_CARGA
      cargar_movimiento_carga(a_hash, id, usuario, monto, fecha_creacion)
    when TIPO_DE_MOV_PAGO_GASTO
      cargar_movimiento_pago_de_gasto(a_hash, id, usuario, monto, fecha_creacion)
    else
      raise TipoDeMovimientoInvalido, a_hash[:tipo]
    end
  end

  def cargar_movimiento_transferencia(a_hash, id, usuario, monto, fecha_creacion)
    usuario_secundario = RepositorioUsuarios.new.find(a_hash[:id_usuario_secundario])
    movimiento = MovimientoTransferencia.new(usuario, monto, usuario_secundario, id:)
    set_created_on(movimiento, fecha_creacion)
    movimiento
  end

  def cargar_movimiento_carga(_a_hash, id, usuario, monto, fecha_creacion)
    movimiento = MovimientoCarga.new(usuario, monto, id:)
    set_created_on(movimiento, fecha_creacion)
    movimiento
  end

  def cargar_movimiento_pago_de_gasto(a_hash, id, usuario, monto, fecha_creacion)
    usuario_pagador = RepositorioUsuarios.new.find(a_hash[:id_usuario_secundario])
    gasto = RepositorioGastos.new.find(a_hash[:id_gasto])
    movimiento = MovimientoPagoDeGasto.new(usuario, monto, gasto, usuario_pagador, id:)
    set_created_on(movimiento, fecha_creacion)
    movimiento
  end

  def set_created_on(movimiento, fecha_creacion)
    movimiento.created_on = fecha_creacion
  end

  def load_object(a_hash)
    id = a_hash[:id]
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario_principal])
    monto = a_hash[:monto]
    fecha_creacion = a_hash[:created_on]
    cargar_movimiento_segun_tipo(a_hash, id, usuario, monto, fecha_creacion)
  end

  def changeset(movimiento)
    movimiento.atributos_serializables
  end
end

class TipoDeMovimientoInvalido < StandardError
  def initialize(tipo)
    @tipo = tipo
    super("Tipo de movimiento #{@tipo} inválido")
  end
end
