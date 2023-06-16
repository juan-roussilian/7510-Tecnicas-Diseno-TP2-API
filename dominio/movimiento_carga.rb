class MovimientoCarga
  attr_reader :usuario, :monto

  def initialize(usuario, monto)
    @usuario = usuario
    @monto = monto
  end
end
