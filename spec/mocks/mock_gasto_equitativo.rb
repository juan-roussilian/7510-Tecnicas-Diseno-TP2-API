class MockGastoEquitativo
  attr_reader :id, :grupo

  def initialize(nombre, monto, grupo, creador, id: nil)
    @nombre = nombre
    @monto = monto
    @grupo = grupo
    @creador = creador
    @id = id
  end
end
