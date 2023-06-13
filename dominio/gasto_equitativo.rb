class GastoEquitativo
  attr_reader :monto, :grupo, :nombre, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, monto, grupo, id: nil)
    @nombre = nombre
    @monto = monto
    @grupo = grupo
    @id = id
  end

  def deuda_por_usuario
    @monto / @grupo.usuarios.count
  end
end
