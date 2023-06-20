require './dominio/bonificador'
require 'webmock'
require 'dotenv/load'

def get_clima_mock(respuesta)
  WebMock.stub_request(:get, "#{ENV['URL_API_CLIMA']}?key=#{ENV['KEY_API_CLIMA']}&q=#{ENV['CIUDAD_API_CLIMA']}&aqi=no")
         .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                          'User-Agent' => 'Faraday v2.7.5' })
         .to_return(status: 200, body: respuesta.to_json, headers: {})
end

describe Bonificador do
  describe 'aplicar bonificacion segun clima y dia' do
    it 'dia domingo con lluvia intensa deberia dar bonificacion del 10%' do
      bonificador = described_class.new
      saldo_inicial = 505.0
      respuesta = { location: { localtime: '2023-06-18 13:00' }, current: { precip_mm: 0.9 } }
      get_clima_mock(respuesta)
      saldo_bonificado = bonificador.aplicar_bonificacion_segun_clima_y_dia(saldo_inicial)
      expect(saldo_bonificado).to eq(saldo_inicial / 10 + saldo_inicial)
    end

    it 'dia lunes con lluvia no bonifica' do
      bonificador = described_class.new
      saldo_inicial = 4000
      respuesta = { location: { localtime: '2023-06-19 13:00' }, current: { precip_mm: 0.9 } }
      get_clima_mock(respuesta)
      saldo_bonificado = bonificador.aplicar_bonificacion_segun_clima_y_dia(saldo_inicial)
      expect(saldo_bonificado).to eq(saldo_inicial)
    end
  end
end
