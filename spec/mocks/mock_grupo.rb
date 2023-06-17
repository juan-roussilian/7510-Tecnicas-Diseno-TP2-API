class MockGrupo
  attr_reader :nombre, :usuarios, :repositorio_grupos

  def initialize(nombre, usuarios, repositorio_grupos)
    @nombre = nombre
    @usuarios = usuarios
    @repositorio_grupos = repositorio_grupos
  end
end
