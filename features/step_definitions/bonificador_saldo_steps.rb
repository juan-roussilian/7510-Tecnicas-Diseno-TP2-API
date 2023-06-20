require 'webmock'

def get_clima_mock(respuesta)
  WebMock.stub_request(:get, "http://api.weatherapi.com/v1/current.json?key=d584af55f0324c59a4941429231606&q=Buenos Aires&aqi=no")
         .to_return(status: 200, body: respuesta.to_json, headers: {})
end
Dado('el dia es {string}') do |dia|
  if dia == 'domingo'
    @fecha = '2023-06-18 13:00'
  else
    @fecha = '2023-06-19 13:00'
  end  
end

Dado('el clima es {string}') do |clima|
  if clima == 'lluvia'
    @mm_lluvia == 0.9
  else
    @mm_lluvia == 0.0
  end
  respuesta = {location:{localtime:@fecha}, current:{precip_mm:@mm_lluvia}}
  get_clima_mock(respuesta)
end

Entonces('mi saldo es de {float}') do |saldo_esperado|
  saldo = JSON.parse(Faraday.get(get_url_for('/saldo'),{ usuario: @usuario.telegram_id } ).body)['saldo']
  expect(saldo).to eq saldo_esperado
end
  