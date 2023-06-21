require 'faraday'
require 'dotenv/load'

STATUS_CODE_OK = 200
MILIMTEROS_MINIMOS_LLUVIA = 0.5
class Bonificador
  def initialize(bonificar_siempre: false, nunca_bonificar: false)
    @api_url = ENV['URL_API_CLIMA']
    @api_key = ENV['KEY_API_CLIMA']
    @ciudad_bonificada = ENV['CIUDAD_API_CLIMA']
    @coeficiente_bonificacion = ENV['COEFICIENTE_BONIFICACION'].to_f
    raise EstadoInvalido if bonificar_siempre && nunca_bonificar

    @bonificar_siempre = bonificar_siempre
    @nunca_bonificar = nunca_bonificar
  end

  def aplicar_bonificacion_segun_clima_y_dia(saldo)
    return saldo * @coeficiente_bonificacion if @bonificar_siempre
    return saldo if @nunca_bonificar

    argumentos = { key: @api_key, q: @ciudad_bonificada, aqi: 'no' }
    respuesta = Faraday.get(@api_url, argumentos)
    if respuesta.status == STATUS_CODE_OK
      info_clima = JSON.parse(respuesta.body)
      lluvia = info_clima['current']['precip_mm'] >= MILIMTEROS_MINIMOS_LLUVIA
      fecha = Date.parse info_clima['location']['localtime']
      return saldo * @coeficiente_bonificacion if fecha.sunday? && lluvia
    end
    saldo
  end
end

class EstadoInvalido < StandardError
  def initialize
    super('No se puede crear un bonificador que siempre bonifique y nunca bonifique en simultaneo.')
  end
end
