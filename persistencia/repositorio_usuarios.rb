require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def find_by_name(nombre)
    found_record = dataset.first(nombre:)
    raise ObjectNotFound.new(self.class.model_class, nombre) if found_record.nil?

    load_object dataset.first(found_record)
  end

  def find_by_id(id)
    found_record = dataset.first(id:)
    raise ObjectNotFound.new(self.class.model_class, id) if found_record.nil?

    load_object dataset.first(found_record)
  end

  protected

  def load_object(a_hash)
    usuario = Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:id])
    usuario.cargar_saldo(a_hash[:saldo])
    usuario
  end

  def changeset(usuario)
    changes = {
      nombre: usuario.nombre,
      saldo: usuario.saldo,
      email: usuario.email
    }
    changes[:id] = usuario.id unless usuario.id.nil?
    changes
  end
end

class ObjectNotFound < StandardError
  def initialize(class_name, id)
    @class_name = class_name
    @id = id
    super("Object #{@class_name} with id #{@id} not found")
  end
end
