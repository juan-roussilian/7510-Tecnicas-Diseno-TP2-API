class MockGrupo
  attr_reader :nombre, :usuarios

  def initialize(nombre, usuarios)
    @nombre = nombre
    @usuarios = usuarios
  end
end
