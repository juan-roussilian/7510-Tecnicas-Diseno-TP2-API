require_relative './movimiento'

class MovimientoTransferencia < Movimiento
  attr_reader :usuario, :monto, :destinatario

  def initialize(usuario, monto, destinatario, id: nil)
    @destinatario = destinatario
    super(usuario, monto, id:)
  end

  def atributos_serializables
    atributos = super
    atributos[:tipo] = 'transferencia'
    atributos[:id_usuario_secundario] = @destinatario.id
    atributos
  end
end
