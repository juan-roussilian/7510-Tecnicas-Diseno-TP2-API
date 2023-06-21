require 'dotenv/load'

STATUS_CODE_OK = 200
MILIMTEROS_MINIMOS_LLUVIA = 0.5
class Bonificador
  def initialize(proveedor_fecha, proveedor_clima)
    @fecha = proveedor_fecha
    @clima = proveedor_clima
    @coeficiente_bonificacion = ENV['COEFICIENTE_BONIFICACION'].to_f
  end

  def aplicar_bonificacion_segun_clima_y_dia(saldo)
    saldo_bonificado = saldo *  @coeficiente_bonificacion
    return saldo_bonificado if ENV['BONIFICAR_SIEMPRE'].to_i == 1

    saldo = saldo_bonificado if @fecha.es_domingo? && @clima.llueve?
    saldo
  end
end
