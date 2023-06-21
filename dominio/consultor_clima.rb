require 'faraday'
require 'dotenv/load'

STATUS_CODE_OK = 200

class ConsultorClima
  def initialize
    @api_url = ENV['URL_API_CLIMA']
    @api_key = ENV['KEY_API_CLIMA']
    @ciudad_bonificada = ENV['CIUDAD_API_CLIMA']
    @coeficiente_bonificacion = ENV['COEFICIENTE_BONIFICACION'].to_f
  end

  def precipitacion_mm
    argumentos = { key: @api_key, q: @ciudad_bonificada, aqi: 'no' }
    respuesta = Faraday.get(@api_url, argumentos)
    if respuesta.status == STATUS_CODE_OK
      info_clima = JSON.parse(respuesta.body)
      info_clima['current']['precip_mm'].to_f

    end
  end
end
