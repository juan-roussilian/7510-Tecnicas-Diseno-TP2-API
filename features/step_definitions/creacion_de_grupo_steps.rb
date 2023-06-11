def usuario_de_prueba_t_id(nombre, telegram_id)
  usuario = Usuario.new(nombre, 'juan@test.com', telegram_id, 'juan')
  usuario.cargar_saldo(0)
  usuario
end

Dado('que soy un usuario registrado') do
  @usuario = usuario_de_prueba_t_id('juan',"50")
  RepositorioUsuarios.new.save(@usuario)
end

Dado('existe un usuario con el nombre {string}') do |telegram_username|
  request_body = { nombre: 'usuario', email: 'usuario@test.com', telegram_username: }.to_json
  respuesta = JSON.parse(Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body)
  @otro_usuario = RepositorioUsuarios.new.find(respuesta['id'])
end

Cuando('quiero crear un grupo con el nombre {string} con el usuario {string}') do |nombre_grupo, usuario|
  otro_usuario = RepositorioUsuarios.new.find_by_telegram_username(usuario)
  request_body = { nombre_grupo: nombre_grupo, usuarios: [@usuario.telegram_id, otro_usuario.telegram_id] }.to_json
  @response = Faraday.post('/grupo', request_body, { 'Content-Type' => 'application/json' })
end

Y('el grupo {string} se crea') do |nombre_grupo|
  # grupo_encontrado = RepositorioGrupos.new.find(nombre_grupo)
  # expect(grupo_encontrado.usuarios.first).to eq @usuario.telegram_username
  expect(RepositorioGrupos.new.existe_grupo(nombre_grupo)).to eq true
  expect(@response.status).to eq 201
end

Entonces('veo el mensaje {string}') do |mensaje|
  expect(@response.body).to eq mensaje
end

When(/^hay algun grupo llamado "([^"]*)"$/) do |nombre|
  request_body = { nombre_grupo: nombre, usuarios: [@usuario.telegram_id, @otro_usuario.telegram_id] }.to_json
  @response = Faraday.post('/grupo', request_body, { 'Content-Type' => 'application/json' })
end

When(/^quiero crear un grupo con el nombre "([^"]*)" con los usuarios "([^"]*)" y "([^"]*)"$/) do |nombre, u1, u2|
  otro_usuario = RepositorioUsuarios.new.find_by_telegram_username(u1)
  otro_usuario2 = RepositorioUsuarios.new.find_by_telegram_username(u2)
  request_body = { nombre_grupo: nombre, usuarios: [@usuario.telegram_id, otro_usuario.telegram_id, otro_usuario2.telegram_id] }.to_json
  @response = Faraday.post('/grupo', request_body, { 'Content-Type' => 'application/json' })
end

When(/^no se crea el grupo$/) do
  expect(@response.status).to eq 400
end
