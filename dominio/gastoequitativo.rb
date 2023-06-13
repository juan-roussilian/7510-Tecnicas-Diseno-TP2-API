class GastoEquitativo
  attr_reader :monto

  def initialize(nombre, monto, grupo)
    @nombre = nombre
    @monto = monto
    @grupo = grupo
  end

  def deuda_por_usuario
    @monto / @grupo.usuarios.count
  end
end
