def usuario_de_prueba(saldo)
  usuario = Usuario.new('Juan', 'juan@test.com')
  usuario.cargar_saldo(saldo)
  usuario
end

Dado('que soy un usuario registrado con saldo "{int}"') do |saldo|
  @usuario = usuario_de_prueba(saldo)
  RepositorioUsuarios.new.save(@usuario)
end

Cuando(/^quiero consultar mi saldo$/) do
  @saldo = @usuario.saldo
end

Entonces('veo en saldo "{int}"') do |saldo_esperado|
  expect(@saldo).to eq saldo_esperado
end

Dado('que soy un nuevo usuario registrado') do
  request_body = { nombre: 'Juan', email: 'juan@test.com' }.to_json
  @carga_de_usuario = JSON.parse(
    Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body
  )
end

Cuando('consulto mi saldo') do
  @usuario = RepositorioUsuarios.new.find(@carga_de_usuario['id'])
  @saldo = @usuario.saldo
end

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
  expect(@usuario.saldo).to eq saldo_esperado
end
