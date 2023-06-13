class Gasto
  attr_reader :monto

  def initialize(nombre, monto, nombre_grupo)
    @nombre = nombre
    @monto = monto
    @nombre_grupo = nombre_grupo
  end
end
