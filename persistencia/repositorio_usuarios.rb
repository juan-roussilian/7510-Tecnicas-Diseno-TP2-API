require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def find_by_name(nombre)
    found_record = dataset.where(nombre:).first
    raise ObjectNotFound.new(self.class.model_class, nombre) if found_record.nil?

    load_object dataset.first(found_record)
  end

  def find_by_telegram_id(telegram_id)
    found_record = dataset.first(telegram_id:)
    raise ObjectNotFound.new(self.class.model_class, telegram_id) if found_record.nil?

    load_object dataset.first(found_record)
  end

  def find_by_telegram_username(telegram_username)
    found_record = dataset.where(telegram_username:).first
    raise ObjectNotFound.new(self.class.model_class, telegram_username) if found_record.nil?

    load_object dataset.first(found_record)
  end

  def find_by_group_name(nombre_grupo)
    grupo_buscado = DB[:grupos].where(nombre: nombre_grupo).first
    raise ObjectNotFound.new('grupo', nombre_grupo) if grupo_buscado.nil?

    usuarios_grupos_dataset = DB[:grupos_usuarios]
    usuarios_en_grupo = usuarios_grupos_dataset.where(grupo_id: grupo_buscado[:id])
    usuarios = []
    usuarios_en_grupo.each do |usuario_en_grupo|
      usuarios << find(usuario_en_grupo[:usuario_id])
    end
    usuarios
  end

  def destroy(usuario)
    grupos_usuario = DB[:grupos_usuarios].where(usuario_id: usuario.id)
    grupos_usuario.delete
    repositorio_movimientos = RepositorioMovimientos.new
    repositorio_movimientos.find_by_usuario_principal(usuario.id).each(&:delete)
    repositorio_movimientos.find_by_usuario_secundario(usuario.id).each(&:delete)
    RepositorioGastos.new.find_by_creador(usuario.id).each(&:delete)
    super
  end
  alias delete destroy

  def delete_all
    grupos_usuarios_dataset = DB[:grupos_usuarios]
    grupos_usuarios_dataset.delete
    RepositorioMovimientos.new.delete_all
    RepositorioGastos.new.delete_all
    super
  end

  protected

  def load_object(a_hash)
    usuario = Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:telegram_id], a_hash[:telegram_username],
                          a_hash[:id])
    usuario.cargar_saldo(a_hash[:saldo])
    usuario
  end

  def changeset(usuario)
    changes = {
      nombre: usuario.nombre,
      saldo: usuario.saldo,
      email: usuario.email,
      telegram_id: usuario.telegram_id,
      telegram_username: usuario.telegram_username
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
