
Dado('existe un usuario con el nombre de telegram {string} con saldo {float}') do |telegram_username, saldo|
  request_body = { nombre: 'usuario', email: 'usuario@test.com', telegram_username: telegram_username }.to_json
  respuesta = JSON.parse(Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body)
  @otro_usuario = RepositorioUsuarios.new.find(respuesta['id'])
  @otro_usuario.cargar_saldo(saldo)
  @otro_usuario_tid = respuesta['telegram_id']
end

Dado('que soy un usuario registrado y poseo saldo {float}') do |saldo|
  request_body = { nombre: 'nombre', email: 'mail@test.com', telegram_id: '8', telegram_username: 'user'}.to_json
  respuesta = JSON.parse(Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body)
  @usuario = RepositorioUsuarios.new.find(respuesta['id'])
  @usuario.cargar_saldo(saldo)
end

Entonces('el saldo del usuario al que le transferi es de {int}') do |saldo_esperado|
  saldo = JSON.parse(Faraday.get('/saldo',{ usuario: @otro_usuario_tid } ).body)['saldo']
  expect(saldo).to eq saldo_esperado
end

Cuando('quiero transferir {float} al usuario registrado {string}') do |monto, nombre|
  request_body = { usuario: @usuario.telegram_id, monto: monto, destinatario: nombre }.to_json
  @transferencia = Faraday.post("/transferir", request_body, { 'Content-Type' => 'application/json' })
end

Entonces('mi saldo pasa a ser {int}') do |saldo_esperado|
  saldo = JSON.parse(Faraday.get('/saldo',{ usuario: @usuario.telegram_id } ).body)['saldo']
  expect(saldo).to eq saldo_esperado
end

When(/^veo que no se puede transferir$/) do
  expect(@transferencia.status).to eq 400
end

When(/^no existe un usuario con el nombre de telegram "([^"]*)"$/) do |arg|
  # nada
end
