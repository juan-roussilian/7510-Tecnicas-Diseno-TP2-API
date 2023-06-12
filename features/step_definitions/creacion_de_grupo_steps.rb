def usuario_de_prueba_telegram_id(nombre, telegram_id)
  usuario = Usuario.new(nombre, 'juan@test.com', telegram_id, 'juan')
  usuario.cargar_saldo(0)
  usuario
end

Dado('que soy un usuario registrado') do
  @usuario = usuario_de_prueba_telegram_id('juan',"50")
  RepositorioUsuarios.new.save(@usuario)
end

Dado('existe un usuario con el nombre {string}') do |telegram_username|
  request_body = { nombre: 'usuario', email: 'usuario@test.com', telegram_username: }.to_json
  respuesta = JSON.parse(Faraday.post(get_url_for('/usuarios'), request_body, { 'Content-Type' => 'application/json' }).body)
  @otro_usuario = RepositorioUsuarios.new.find(respuesta['id'])
end

Cuando('quiero crear un grupo con el nombre {string} con el usuario {string}') do |nombre, otro_usuario|
  RepositorioGrupos.new.delete_all
  request_body = { nombre:, usuarios: [@usuario.telegram_username, otro_usuario] }.to_json
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
  request_body = { nombre_grupo: nombre, usuarios: [@usuario.telegram_id, @otro_usuario.telegram_id] }.to_json
  @response = Faraday.post(get_url_for('/grupo'), request_body, { 'Content-Type' => 'application/json' })
end

Cuando(/^quiero crear un grupo con el nombre "([^"]*)" con los usuarios "([^"]*)" y "([^"]*)"$/) do |nombre, u1, u2|
  RepositorioGrupos.new.delete_all
  request_body = { nombre: nombre, usuarios: [@usuario.telegram_username, u1, u2] }.to_json
  @response = Faraday.post(get_url_for('/grupo'), request_body, { 'Content-Type' => 'application/json' })
end

Cuando(/^no se crea el grupo$/) do
  expect(@response.status).to eq 400
end
