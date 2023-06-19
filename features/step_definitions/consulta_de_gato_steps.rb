Dado(/^estoy en un grupo que tiene gasto con un id$/) do
  telegram_username = 'telegram_username'
  request_body_usuario = { nombre: telegram_username, email: 'usuario@test.com', telegram_id: 0, telegram_username: telegram_username }.to_json
  Faraday.post(get_url_for('/usuarios'), request_body_usuario, { 'Content-Type' => 'application/json' })
  otro_usuario = RepositorioUsuarios.new.find_by_name(telegram_username)
  request_body = { nombre_grupo: 'grupo', usuarios: [@usuario.telegram_username, otro_usuario.telegram_username] }.to_json
  Faraday.post(get_url_for('/grupo'), request_body, { 'Content-Type' => 'application/json' })
  request_body_gasto = { usuario: 0, nombre_gasto: 'gasto', monto: 100, nombre_grupo: 'grupo' }.to_json
  respuesta = Faraday.post(get_url_for('/gasto'), request_body_gasto, { 'Content-Type' => 'application/json' })
  @id = JSON.parse(respuesta.body)['id']
end

Cuando(/^quiero consultar los detalles del gasto con el id del gasto$/) do
  request_body = { usuario: @usuario.telegram_id, gasto: @id }
  @respuesta = Faraday.get(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
end

Entonces(/^veo el detalle del gasto$/) do
  definicion = JSON.parse(@respuesta.body)
  expect(@respuesta.status).to eq 200
  expect(definicion['usuarios'].size).to eq 1
  expect(definicion['estado']).to eq 'Pendiente'
end

Cuando('que me registre') do
  nombre = 'juancito'
  request_body = { nombre: nombre, email: "#{nombre}@usuario.com", id: 100, telegram_username: nombre }.to_json
  @response = Faraday.post(get_url_for('/usuarios'), request_body, { 'Content-Type' => 'application/json' })
  @usuario = RepositorioUsuarios.new.find_by_telegram_username(nombre)
end
