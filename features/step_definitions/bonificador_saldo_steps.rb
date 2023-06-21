Dado('el dia es {string} y el clima es {string}') do|dia, clima|
  if dia == 'domingo' && clima == 'lluvia'
    @bonificar_siempre = true
  else
    @no_bonificar = true
  end  
end

Cuando('cargo un monto de {float}') do |saldo|
  request_body = { telegram_id: @usuario.telegram_id, saldo: saldo, bonificar_siempre: @bonificar_siempre, no_bonificar: @no_bonificar}.to_json
  @resultado_carga = Faraday.post(get_url_for('/saldo'), request_body, { 'Content-Type' => 'application/json' })
end

Entonces('mi saldo es de {float}') do |saldo_esperado|
  saldo = JSON.parse(Faraday.get(get_url_for('/saldo'),{ usuario: @usuario.telegram_id } ).body)['saldo']
  expect(saldo).to eq saldo_esperado
end
  