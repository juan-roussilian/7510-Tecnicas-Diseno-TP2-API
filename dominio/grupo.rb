class Grupo
  attr_reader :nombre, :usuarios

  def initialize(nombre, usuarios, repositorio_usuarios)
    @nombre = nombre
    @usuarios = []
    usuarios.each do |telegram_username|
      usuario = repositorio_usuarios.find_by_telegram_username(telegram_username)
      @usuarios.push(usuario)
    end
  end
end
