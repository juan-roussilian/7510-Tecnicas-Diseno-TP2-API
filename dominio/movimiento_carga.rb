require_relative './movimiento'

class MovimientoCarga < Movimiento
  TIPO_DE_MOV_CARGA = 'carga'.freeze

  def initialize(usuario, monto, id: nil)
    super
  end

  def atributos_serializables
    atributos = super
    atributos[:tipo] = TIPO_DE_MOV_CARGA
    atributos[:id_usuario_secundario] = nil
    atributos[:id_gasto] = nil
    atributos
  end
end
