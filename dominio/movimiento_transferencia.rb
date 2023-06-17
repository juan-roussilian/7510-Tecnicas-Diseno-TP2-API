class MovimientoTransferencia
  attr_reader :usuario, :monto, :destinatario

  def initialize(usuario, monto, destinatario)
    @usuario = usuario
    @monto = monto
    @destinatario = destinatario
  end
end
