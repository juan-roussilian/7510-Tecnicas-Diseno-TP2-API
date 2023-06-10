Dado('que soy un usuario registrado') do
  @usuario = usuario_de_prueba(0)
  RepositorioUsuarios.new.save(@usuario)
end

Dado('existe un usuario con el nombre {string}') do |telegram_username|
  request_body = { nombre: 'usuario', email: 'usuario@test.com', telegram_username: }.to_json
  respuesta = JSON.parse(Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body)
  @otro_usuario = RepositorioUsuarios.new.find(respuesta['id'])
end

Cuando('quiero crear un grupo con el nombre {string} con el usuario {string}') do |nombre_grupo, usuario|
  @usuario = usuario
  request_body = { nombre_grupo: , usuarios: [usuario] }.to_json
  @response = Faraday.post('/grupo', request_body, { 'Content-Type' => 'application/json' })
end

Y('el grupo {string} se crea') do |nombre_grupo|
  grupo_encontrado = RepositorioGrupos.new.find(nombre_grupo)
  expect(grupo_encontrado.usuarios.first).to eq @usuario.telegram_username
  expect(@response.status).to eq 201
end

Entonces('veo el mensaje {string}') do |mensaje|
  expect(@response.body).to eq mensaje
end

