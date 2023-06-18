require_relative './movimiento'

class MovimientoCarga < Movimiento
  def initialize(usuario, monto, id: nil)
    super
  end

  def obtener_changeset
    changes = super
    changes[:tipo] = 'carga saldo'
    changes
  end
end
