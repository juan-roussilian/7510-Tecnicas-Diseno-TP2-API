require 'faraday'

class Bonificador
  def initialize
    @api_url = ENV['URL_API_CLIMA'] || 'http://api.weatherapi.com/v1/current.json'
    @api_key = ENV['API_CLIMA_KEY'] || 'd584af55f0324c59a4941429231606'
  end

  def aplicar_bonificacion_segun_clima_y_dia(saldo)
    saldo + saldo / 10
  end
end
