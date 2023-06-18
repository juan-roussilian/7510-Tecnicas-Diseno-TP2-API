def usuario_de_prueba(saldo)
  usuario = Usuario.new('Juan', 'juan@test.com', "1", 'juan')
  usuario.cargar_saldo(saldo, RepositorioUsuarios.new, RepositorioMovimientos.new)
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
  request_body = { nombre: 'Juan', email: 'juan@mail.com', telegram_id: 1, telegram_username: 'juan' }.to_json
  @respuesta = JSON.parse(
    Faraday.post(get_url_for('/usuarios'), request_body, { 'Content-Type' => 'application/json' }).body
    )
end
  
Cuando('consulto mi saldo') do
  @saldo = JSON.parse(Faraday.get(get_url_for('/saldo'),{ usuario: @respuesta['telegram_id'] } ).body)['saldo']
end
  
Entonces('veo en saldo "{int}"') do |saldo_esperado|
  expect(@saldo).to eq saldo_esperado
end

Dado('cargo saldo "{int}"') do |saldo|
  repo_usuarios = RepositorioUsuarios.new
  @usuario = repo_usuarios.find(@respuesta['id'])
  @usuario.cargar_saldo(saldo,repo_usuarios)
end
