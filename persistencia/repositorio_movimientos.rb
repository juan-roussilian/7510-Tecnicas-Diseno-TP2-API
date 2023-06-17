require_relative './abstract_repository'
class RepositorioMovimientos < AbstractRepository
  self.table_name = :movimientos
  self.model_class = 'Movimiento'

  protected

  def load_object(a_hash)
    id = a_hash[:id]
    usuario = RepositorioUsuarios.new.find_by_id(a_hash[:usuario_id])
    monto = a_hash[:monto]
    MovimientoCarga.new(usuario, monto, id:)
  end

  def changeset(movimiento)
    {
      id_usuario_principal: movimiento.usuario.id,
      monto: movimiento.monto
    }
  end
end
