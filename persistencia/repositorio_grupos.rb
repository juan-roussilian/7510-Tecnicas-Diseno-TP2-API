require_relative './abstract_repository'

class RepositorioGrupos < AbstractRepository
  self.table_name = :grupos
  self.model_class = 'Grupo'

  def save(a_record)
    if find_dataset_by_name(a_record.nombre).first
      update(a_record)
    else
      insert(a_record)
    end
    a_record
  end

  def find_by_name(nombre)
    found_record = dataset.where(nombre:).first
    raise GrupoNoEncontrado.new(self.class.model_class, nombre) if found_record.nil?

    load_object dataset.first(found_record)
  end

  def existe_grupo(nombre)
    !dataset.where(nombre:).first.nil?
  end

  protected

  def find_dataset_by_name(nombre)
    dataset.where(nombre:)
  end

  def load_object(a_hash)
    # grupo = Grupo.new(a_hash['nombre'])
    # grupo
  end

  def changeset(grupo)
    {
      nombre: grupo.nombre
    }
  end

  def update(a_record)
    find_dataset_by_name(a_record.nombre).update(update_changeset(a_record))
  end

  def insert(a_record)
    dataset.insert(insert_changeset(a_record))
    a_record
  end
end

class GrupoNoEncontrado < StandardError
  def initialize(nombre)
    @nombre = nombre
    super("Grupo con nombre #{@nombre} no encontrado")
  end
end
