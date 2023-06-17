class MovimientoTransferencia
  attr_reader :monto

  def initialize(usuario, monto)
    @usuario = usuario
    @monto = monto
  end
end
