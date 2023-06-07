def usuario_de_prueba(saldo)
  usuario = Usuario.new('Juan', 'juan@test.com', 1)
  usuario.cargar_saldo(saldo)
  usuario
end

Dado('que soy un usuario registrado con saldo "{int}"') do |saldo|
  @usuario = usuario_de_prueba(saldo)
  RepositorioUsuarios.new.save(@usuario)
end
# step que no usa el comando 
Cuando(/^quiero consultar mi saldo$/) do
  @saldo = @usuario.saldo
end

Dado('que soy un nuevo usuario registrado') do
  request_body = { nombre: 'Juan', email: 'juan@mail.com', telegram_id: 1 }.to_json
  @respuesta = JSON.parse(
    Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body
    )
end
  
Cuando('consulto mi saldo') do
  @saldo = JSON.parse(Faraday.get('/saldo',{ usuario: @respuesta['telegram_id'] } ).body)['saldo']
end
  
Entonces('veo en saldo "{int}"') do |saldo_esperado|
  expect(@saldo).to eq saldo_esperado
end

Dado('cargo saldo "{int}"') do |saldo|
  @usuario = RepositorioUsuarios.new.find(@respuesta['id'])
  @usuario.cargar_saldo(saldo)
end
