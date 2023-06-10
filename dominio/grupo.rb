class Grupo
  attr_reader :nombre, :usuarios, :updated_on, :created_on

  MINIMO_USUARIOS_POR_GRUPO = 2

  def initialize(nombre, usuarios, repositorio_usuarios)
    raise MiembrosInsuficientesParaGrupo, nombre if usuarios.count < MINIMO_USUARIOS_POR_GRUPO

    @nombre = nombre
    @usuarios = []
    usuarios.each do |telegram_username|
      usuario = repositorio_usuarios.find_by_telegram_username(telegram_username)
      @usuarios.push(usuario)
    end
  end
end

class MiembrosInsuficientesParaGrupo < StandardError
  def initialize(nombre)
    @nombre = nombre
    super("Falla al crear grupo #{@nombre}, miembros insuficientes.")
  end
end
