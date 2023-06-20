require './dominio/bonificador'
require 'webmock'

def get_clima_mock(respuesta)
  WebMock.stub_request(:get, 'http://api.weatherapi.com/v1/current.json?key=d584af55f0324c59a4941429231606&q=Buenos Aires&aqi=no')
         .to_return(status: 200, body: respuesta.to_json, headers: {})
end

describe Bonificador do
  describe 'aplicar bonificacion segun clima y dia' do
    it 'dia domingo con lluvia intensa deberia dar bonificacion del 10%' do
      bonificador = described_class.new
      saldo_inicial = 505
      saldo_bonificado = bonificador.aplicar_bonificacion_segun_clima_y_dia(saldo_inicial)
      respuesta = { location: { localtime: '2023-06-18 13:00' }, current: { precip_mm: 0.9 } }
      get_clima_mock(respuesta)
      expect(saldo_bonificado).to eq(saldo_inicial / 10 + saldo_inicial)
    end
  end
end
