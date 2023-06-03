require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  protected

  def load_object(a_hash)
    Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:id])
  end

  def changeset(usuario)
    {
      nombre: usuario.nombre,
      email: usuario.email
    }
  end
end
