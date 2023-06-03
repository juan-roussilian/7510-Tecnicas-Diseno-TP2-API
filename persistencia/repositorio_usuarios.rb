require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def find_by_mail(mail)
    found_record = dataset.first(pk_column => mail)
    raise ObjectNotFound.new(self.class.model_class, mail) if found_record.nil?

    load_object dataset.first(found_record)
  end

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
