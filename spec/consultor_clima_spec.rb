require './dominio/consultor_clima'
require 'webmock'
require 'dotenv/load'

def get_clima_mock(respuesta)
  WebMock.stub_request(:get, "#{ENV['URL_API_CLIMA']}?key=#{ENV['KEY_API_CLIMA']}&q=#{ENV['CIUDAD_API_CLIMA']}&aqi=no")
         .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                          'User-Agent' => 'Faraday v2.7.5' })
         .to_return(status: 200, body: respuesta.to_json, headers: {})
end

describe ConsultorClima do
  describe 'obtener precipitacion clima' do
    it 'deberia devolver correctamente el valor de precipitacion' do
      precipitacion = 0.6
      respuesta = { location: { name: 'Buenos Aires' }, current: { precip_mm: precipitacion } }
      get_clima_mock(respuesta)
      expect(described_class.new.precipitacion_mm).to eq(precipitacion)
    end
  end
end
