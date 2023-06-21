require 'faraday'
require 'dotenv/load'

STATUS_CODE_OK = 200
MILIMTEROS_MINIMOS_LLUVIA = 0.5
class Bonificador
  def initialize(proveedor_fecha, proveedor_clima)
    @fecha = proveedor_fecha
    @clima = proveedor_clima
    @api_url = ENV['URL_API_CLIMA']
    @api_key = ENV['KEY_API_CLIMA']
    @ciudad_bonificada = ENV['CIUDAD_API_CLIMA']
    @coeficiente_bonificacion = ENV['COEFICIENTE_BONIFICACION'].to_f
  end

  def aplicar_bonificacion_segun_clima_y_dia(saldo)
    saldo *= @coeficiente_bonificacion if @fecha.es_domingo? && @clima.llueve?
    saldo
  end
end
