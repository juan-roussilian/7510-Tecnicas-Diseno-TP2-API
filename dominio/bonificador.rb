require 'faraday'
require 'dotenv/load'

COEFICIENTE_BONIFICACION = 0.1
STATUS_CODE_OK = 200
class Bonificador
  def initialize
    @api_url = ENV['URL_API_CLIMA']
    @api_key = ENV['KEY_API_CLIMA']
    @ciudad_bonificada = ENV['CIUDAD_API_CLIMA']
  end

  def aplicar_bonificacion_segun_clima_y_dia(saldo)
    argumentos = { key: @api_key, q: @ciudad_bonificada, aqi: 'no' }
    respuesta = Faraday.get(@api_url, argumentos)
    if respuesta.status == STATUS_CODE_OK
      info_clima = JSON.parse(respuesta.body)
      fecha = Date.parse info_clima['location']['localtime']
      return saldo + (saldo * COEFICIENTE_BONIFICACION) if fecha.sunday?
    end
    saldo
  end
end
