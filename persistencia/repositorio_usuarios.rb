require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def find_by_name(nombre)
    found_record = dataset.first(nombre:)
    raise ObjectNotFound.new(self.class.model_class, nombre) if found_record.nil?

    load_object dataset.first(found_record)
  end

  protected

  def load_object(a_hash)
    usuario = Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:id])
    usuario.cargar_saldo(a_hash[:saldo])
    usuario
  end

  def changeset(usuario)
    {
      nombre: usuario.nombre,
      saldo: usuario.saldo,
      email: usuario.email
    }
  end
end
