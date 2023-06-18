require_relative './abstract_repository'
class RepositorioMovimientos < AbstractRepository
  self.table_name = :movimientos
  self.model_class = 'Movimiento'

  def find_by_usuario_principal(id_usuario_principal)
    movimiento_buscado = DB[:movimientos].where(id_usuario_principal:).first
    raise ObjectNotFound.new('movimiento de usuario principal', id_usuario_principal) if movimiento_buscado.nil?

    load_object dataset.first(movimiento_buscado)
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

  def cargar_movimiento_segun_tipo(a_hash, id, usuario, monto)
    case a_hash[:tipo]
    when 'transferencia'
      usuario_secundario = RepositorioUsuarios.new.find(a_hash[:id_usuario_secundario])
      MovimientoTransferencia.new(usuario, monto, usuario_secundario, id:)
    when 'carga saldo'
      MovimientoCarga.new(usuario, monto, id:)
    when 'pago gasto'
      usuario_pagador = RepositorioUsuarios.new.find(a_hash[:id_usuario_secundario])
      gasto = RepositorioGastos.new.find(a_hash[:id_gasto])
      MovimientoPagoDeGasto.new(usuario, monto, gasto, usuario_pagador, id:)
    else
      raise TipoDeMovimientoInvalido, a_hash[:tipo]
    end
  end

  def load_object(a_hash)
    id = a_hash[:id]
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario_principal])
    monto = a_hash[:monto]
    cargar_movimiento_segun_tipo(a_hash, id, usuario, monto)
  end

  def changeset(movimiento)
    movimiento.obtener_changeset
  end
end

class TipoDeMovimientoInvalido < StandardError
  def initialize(tipo)
    @tipo = tipo
    super("Tipo de movimiento #{@tipo} inválido")
  end
end
