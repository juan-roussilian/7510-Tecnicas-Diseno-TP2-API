require_relative './movimiento'

class MovimientoCarga < Movimiento
  def initialize(usuario, monto, id: nil)
    super
  end

  def atributos_serializables
    atributos = super
    atributos[:tipo] = 'carga saldo'
    atributos
  end
end
