Dado('cargo saldo "{int}"') do |saldo|
  @usuario = RepositorioUsuarios.new.find(@carga_de_usuario['id'])
  @usuario.cargar_saldo(saldo)
end

Dado('que soy un usuario con saldo "{int}"') do |saldo|
  request_body = { nombre: 'Juan', email: 'juan@test.com' }.to_json
  @carga_de_usuario = JSON.parse(
    Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body
  )
  @usuario = RepositorioUsuarios.new.find(@carga_de_usuario['id'])
  @usuario.cargar_saldo(saldo)
end

Entonces('mi saldo pasa a ser "{int}"') do |saldo_esperado|
  expect(@saldo).to eq saldo_esperado
end
