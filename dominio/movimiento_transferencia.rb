require_relative './movimiento'

class MovimientoTransferencia < Movimiento
  attr_reader :usuario, :monto, :destinatario

  def initialize(usuario, monto, destinatario, id: nil)
    @destinatario = destinatario
    super(usuario, monto, id:)
  end

  def obtener_changeset
    changes = super
    changes[:tipo] = 'transferencia'
    changes[:id_usuario_secundario] = @destinatario.id
    changes
  end
end
