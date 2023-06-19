class MockRepositorioGrupos
  def initialize
    @grupos = []
  end

  def find_by_name(nombre)
    grupo = @grupos.find { |g| g.nombre == nombre }
    raise GrupoNoEncontrado, nombre if grupo.nil?

    grupo
  end

  def find(id)
    grupo = @grupos.find { |g| g.id == id }
    raise GrupoNoEncontrado, id if grupo.nil?

    grupo
  end

  def save(grupo)
    @grupos << grupo
  end

  def delete_all
    @grupos = []
  end
end
