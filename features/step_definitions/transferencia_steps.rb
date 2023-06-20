Dado('existe un usuario con el nombre de telegram {string} con saldo {float}') do |telegram_username, saldo|
  request_body = { nombre: 'usuario', email: 'usuario@test.com', telegram_id: '2', telegram_username: telegram_username }.to_json
  respuesta = JSON.parse(Faraday.post(get_url_for('/usuarios'), request_body, { 'Content-Type' => 'application/json' }).body)
  repositorio_usuarios = RepositorioUsuarios.new
  @otro_usuario = repositorio_usuarios.find(respuesta['id'])
  @otro_usuario.cargar_saldo(saldo, repositorio_usuarios, RepositorioMovimientos.new)
end

Dado('que soy un usuario registrado y poseo saldo {float}') do |saldo|
  RepositorioUsuarios.new.delete_all
  request_body = { nombre: 'nombre', email: 'mail@test.com', telegram_id: '1', telegram_username: 'user'}.to_json
  respuesta = JSON.parse(Faraday.post(get_url_for('/usuarios'), request_body, { 'Content-Type' => 'application/json' }).body)
  repo_usuarios = RepositorioUsuarios.new
  @usuario = repo_usuarios.find(respuesta['id'])
  @usuario.cargar_saldo(saldo,repo_usuarios)
end

Entonces('el saldo del usuario al que le transferi es de {int}') do |saldo_esperado|
  saldo = JSON.parse(Faraday.get(get_url_for('/saldo'),{ usuario: @otro_usuario.telegram_id } ).body)['saldo']
  expect(saldo).to eq saldo_esperado
end

Cuando('quiero transferir {float} al usuario registrado {string}') do |monto, nombre|
  request_body = { usuario: @usuario.telegram_id, monto: monto, destinatario: nombre, test_mode:true }.to_json
  @transferencia = Faraday.post(get_url_for('/transferir'), request_body, { 'Content-Type' => 'application/json' })
end

Entonces('mi saldo pasa a ser {int}') do |saldo_esperado|
  saldo = JSON.parse(Faraday.get(get_url_for('/saldo'),{ usuario: @usuario.telegram_id } ).body)['saldo']
  expect(saldo).to eq saldo_esperado
end

Entonces(/^veo que no se puede transferir$/) do
  expect(@transferencia.status).to eq 400
end

When(/^no existe un usuario con el nombre de telegram "([^"]*)"$/) do |arg|
  # nada
end
