require './dominio/gasto_equitativo'
require './dominio/gasto_a_la_gorra'

class CreadorDeGasto
  GORRA = 'gorra'.freeze
  EQUITATIVO = 'equitativo'.freeze
  def crear_gasto(nombre, monto, grupo, creador, tipo)
    case tipo
    when GORRA
      GastoALaGorra.new(nombre, monto, grupo, creador)
    when EQUITATIVO
      GastoEquitativo.new(nombre, monto, grupo, creador)
    else
      raise TipoDeGastoInexistente, tipo
    end
  end
end

class TipoDeGastoInexistente < StandardError
  def initialize(tipo)
    super("No existe el tipo de gasto #{tipo}")
  end
end
