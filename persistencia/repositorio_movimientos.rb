require_relative './abstract_repository'
class RepositorioMovimientos < AbstractRepository
  self.table_name = :movimientos
  self.model_class = 'Movimiento'

  def find_by_usuario_principal(id_usuario_principal)
    movimiento_buscado = DB[:movimientos].where(id_usuario_principal:).first
    raise ObjectNotFound.new('movimiento', id_usuario_principal) if movimiento_buscado.nil?

    load_object dataset.first(movimiento_buscado)
  end

  protected

  def load_object(a_hash)
    id = a_hash[:id]
    usuario = RepositorioUsuarios.new.find(a_hash[:id_usuario_principal])
    monto = a_hash[:monto]
    if a_hash[:tipo] == 'transferencia'
      usuario_secundario = RepositorioUsuarios.new.find(a_hash[:id_usuario_secundario])
      MovimientoTransferencia.new(usuario, monto, usuario_secundario, id:)
    else
      MovimientoCarga.new(usuario, monto, id:)
    end
  end

  def changeset(movimiento)
    changes = {
      id_usuario_principal: movimiento.usuario.id,
      monto: movimiento.monto
    }
    tipo = nil
    id_usuario_secundario = nil
    if movimiento.instance_of?(MovimientoCarga)
      tipo = 'carga saldo'
    elsif movimiento.instance_of?(MovimientoTransferencia)
      tipo = 'transferencia'
      id_usuario_secundario = movimiento.destinatario.id
    end
    changes[:tipo] = tipo
    changes[:id_usuario_secundario] = id_usuario_secundario
    changes
  end
end
