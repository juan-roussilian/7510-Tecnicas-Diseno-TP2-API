class Grupo
  attr_reader :nombre, :usuarios, :updated_on, :created_on

  MINIMO_USUARIOS_POR_GRUPO = 2

  def initialize(nombre, usuarios, repositorio_usuarios, repositorio_grupos = nil)
    miembros_suficientes(nombre, usuarios)
    nombre_unico(nombre, repositorio_grupos)

    @nombre = nombre
    @usuarios = []
    usuarios.each do |telegram_username|
      usuario = repositorio_usuarios.find_by_telegram_username(telegram_username)
      @usuarios.push(usuario)
    end
  end

  private

  def miembros_suficientes(nombre, usuarios)
    raise MiembrosInsuficientesParaGrupo, nombre if usuarios.count < MINIMO_USUARIOS_POR_GRUPO
  end

  def nombre_unico(nombre, repositorio_grupos)
    return if repositorio_grupos.nil?
    raise NombreDeGrupoRepetido, nombre if repositorio_grupos.existe_grupo(nombre)
  end
end

class MiembrosInsuficientesParaGrupo < StandardError
  def initialize(nombre)
    @nombre = nombre
    super("Falla al crear grupo #{@nombre}, miembros insuficientes.")
  end
end

class NombreDeGrupoRepetido < StandardError
  def initialize(nombre)
    @nombre = nombre
    super("Falla al crear grupo #{@nombre}, nombre repetido.")
  end
end
