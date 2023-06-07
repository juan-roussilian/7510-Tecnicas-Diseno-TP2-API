
Dado('que soy un usuario con saldo "{int}"') do |saldo|
  request_body = { nombre: 'Juan', email: 'juan@test.com', id: 1 }.to_json
  respuesta = JSON.parse(
    Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body
  )
  @usuario = RepositorioUsuarios.new.find(respuesta['id'])
  @usuario.cargar_saldo(saldo)
end

Cuando('quiero cargar saldo "{int}"') do |saldo|
  request_body = { id: @usuario.id, saldo: saldo }.to_json
  Faraday.post('/saldo', request_body, { 'Content-Type' => 'application/json' }).body
end

Entonces('mi saldo pasa a ser "{int}"') do |saldo_esperado|
  @saldo = JSON.parse(Faraday.get('/saldo',{ usuario: @usuario.id } ).body)['saldo']
  expect(@saldo).to eq saldo_esperado
end
