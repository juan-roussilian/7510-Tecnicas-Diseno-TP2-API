class GastoEquitativo
  attr_reader :monto, :grupo, :nombre, :creador, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, monto, grupo, creador, id: nil)
    @nombre = nombre
    @monto = monto
    @grupo = grupo
    @creador = creador
    @id = id
  end

  def deuda_por_usuario
    @monto / @grupo.usuarios.count
  end
end
