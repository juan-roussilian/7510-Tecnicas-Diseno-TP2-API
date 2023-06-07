
Dado('que soy un usuario con saldo "{int}"') do |saldo|
  request_body = { nombre: 'Juan', email: 'juan@test.com' }.to_json
  @respuesta = JSON.parse(
    Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body
  )
  @usuario = RepositorioUsuarios.new.find(@respuesta['id'])
  @usuario.cargar_saldo(saldo)
end

Dado('cargo saldo "{int}"') do |saldo|
  @usuario = RepositorioUsuarios.new.find(@respuesta['id'])
  @usuario.cargar_saldo(saldo)
end

Entonces('mi saldo pasa a ser "{int}"') do |saldo_esperado|
  expect(@saldo).to eq saldo_esperado
end
