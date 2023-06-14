def usuario_de_prueba_telegram_id(nombre, telegram_id)
  usuario = Usuario.new(nombre, "#{nombre}n@test.com", telegram_id, nombre)
  usuario.cargar_saldo(0)
  usuario
end

def existe_grupo(nombre)
  begin
    RepositorioGrupos.new.find_by_name(nombre)
  rescue GrupoNoEncontrado
    false
  else
    true
  end
end

Dado('que soy un usuario registrado') do
  @usuario = usuario_de_prueba_telegram_id('UsuarioRegistrado',"50")
  RepositorioUsuarios.new.save(@usuario)
end

Dado('existe un usuario con el nombre {string}') do |telegram_username|
  request_body = { nombre: telegram_username, email: 'usuario@test.com', telegram_id:0, telegram_username: telegram_username }.to_json
  respuesta = Faraday.post(get_url_for('/usuarios'), request_body, { 'Content-Type' => 'application/json' })
  @otro_usuario = RepositorioUsuarios.new.find_by_name(telegram_username)
  expect(respuesta.status).to eq 201
end

Cuando('quiero crear un grupo con el nombre {string} con el usuario {string}') do |nombre_grupo, otro_usuario|
  request_body = { nombre_grupo:, usuarios: [@usuario.telegram_username, otro_usuario] }.to_json
  @response = Faraday.post(get_url_for('/grupo'), request_body, { 'Content-Type' => 'application/json' })
end

Y('el grupo {string} se crea') do |nombre_grupo|
  grupo_encontrado = RepositorioGrupos.new.find_by_name(nombre_grupo)
  expect(grupo_encontrado.nombre).to eq nombre_grupo
  expect(@response.status).to eq 201
end

Entonces('veo el mensaje {string}') do |mensaje|
  expect(@response.body).to eq mensaje
end

Cuando(/^hay algun grupo llamado "([^"]*)"$/) do |nombre|
  RepositorioGrupos.new.delete_all
  request_body = { nombre_grupo: nombre, usuarios: [@usuario.telegram_username, @otro_usuario.telegram_username] }.to_json
  response = Faraday.post(get_url_for('/grupo'), request_body, { 'Content-Type' => 'application/json' })
  expect(response.status).to eq 201
  expect(existe_grupo(nombre)).to eq true
end

Cuando(/^quiero crear un grupo con el nombre "([^"]*)" con los usuarios "([^"]*)" y "([^"]*)"$/) do |nombre, u1, u2|
  usuario1 = RepositorioUsuarios.new.find_by_name(u1)
  usuario2 = RepositorioUsuarios.new.find_by_name(u2)
  request_body = { nombre_grupo: nombre, usuarios: [@usuario.telegram_username, usuario1.telegram_username, usuario2.telegram_username] }.to_json
  @response = Faraday.post(get_url_for('/grupo'), request_body, { 'Content-Type' => 'application/json' })
  expect(existe_grupo(nombre)).to eq true
end

Cuando(/^no se crea el grupo$/) do
  expect(@response.status).to eq 400
end

When(/^veo el mensaje de error "([^"]*)"$/) do |mensaje|
  expect(JSON.parse(@response.body)['error']).to eq mensaje
end
