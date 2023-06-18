require_relative './movimiento'

class MovimientoTransferencia < Movimiento
  attr_reader :usuario, :monto, :destinatario

  def initialize(usuario, monto, destinatario, id: nil)
    @destinatario = destinatario
    super(usuario, monto, id:)
  end
end
