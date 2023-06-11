require_relative './abstract_repository'
require 'byebug'
class RepositorioGrupos < AbstractRepository
  self.table_name = :grupos
  self.model_class = 'Grupo'

  def save(a_record)
    if find_dataset_by_id(a_record.id).first
      update(a_record)
    else
      !insert(a_record)
    end
    save_users(a_record)
    a_record
  end

  def destroy(group)
    users_group_dataset = DB[:grupos_usuarios]
    users_group = users_group_dataset.where(id_grupo: group.id)
    users_group.delete
    find_dataset_by_id(group.id).delete
  end

  alias delete destroy

  def delete_all
    users_group_dataset = DB[:grupos_usuarios]
    users_group_dataset.delete
    super
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

  def load_object(a_hash)
    nombre = a_hash[:nombre]
    id = a_hash[:id]
    users = RepositorioUsuarios.new.find_by_group_name(nombre)
    Grupo.new(nombre, users, id:)
  end

  def save_users(group)
    users_group_dataset = DB[:grupos_usuarios]
    users_repo = RepositorioUsuarios.new
    group.usuarios.each do |user|
      users_repo.save(user)
      users_group_dataset.insert(grupo_id: group.id, usuario_id: user.id)
    end
  end

  def changeset(grupo)
    {
      nombre: grupo.nombre
    }
  end
end

class GrupoNoEncontrado < StandardError
  def initialize(nombre)
    @nombre = nombre
    super("Grupo con nombre #{@nombre} no encontrado")
  end
end
