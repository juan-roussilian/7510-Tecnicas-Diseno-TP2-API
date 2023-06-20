Dado('estoy en un grupo con {string}') do |nombre_otro_usuario|
  repositorio_usuarios = RepositorioUsuarios.new
  repositorio_usuarios.delete_all
  otro_usuario = Usuario.new('user', 'userprueba@test.com', 'IdTelegram1', nombre_otro_usuario)
  repositorio_usuarios.save(otro_usuario)
  repositorio_grupos = RepositorioGrupos.new
  repositorio_grupos.delete_all
  @grupo = Grupo.new('grupo', [@usuario, otro_usuario], repositorio_grupos)
  repositorio_grupos.save(@grupo)
end

Dado('estoy en un grupo con {string}, {string} y {string}') do |nombre_otro_usuario1, nombre_otro_usuario2, nombre_otro_usuario3|
  repositorio_usuarios = RepositorioUsuarios.new
  repositorio_usuarios.delete_all
  otro_usuario1 = Usuario.new('usuario1', 'userprueba1@test.com', 'IdTelegram1', nombre_otro_usuario1)
  otro_usuario2 = Usuario.new('usuario2', 'userprueba2@test.com', 'IdTelegram2', nombre_otro_usuario2)
  otro_usuario3 = Usuario.new('usuario3', 'userprueba3@test.com', 'IdTelegram3', nombre_otro_usuario3)
  repositorio_usuarios.save(otro_usuario1)
  repositorio_usuarios.save(otro_usuario2)
  repositorio_usuarios.save(otro_usuario3)
  repositorio_grupos = RepositorioGrupos.new
  repositorio_grupos.delete_all
  @grupo = Grupo.new('pruebaGrupoGastos', [@usuario, otro_usuario1, otro_usuario2, otro_usuario3], repositorio_grupos)
  repositorio_grupos.save(@grupo)
end

Cuando('quiero crear un gasto equitativo de {string} con el nombre {string}') do |monto, nombre_gasto|
  request_body = { usuario: @usuario.telegram_id, nombre_gasto:, monto:, nombre_grupo: @grupo.nombre }.to_json
  @respuesta = Faraday.post(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
end

Entonces('veo el mensaje gasto creado con id numerico') do
  response_body = JSON.parse(@respuesta.body)
  @id_gasto = response_body['id'] 
  expect(@id_gasto.is_a? Integer).to eq true
end

Entonces('debo pagar {string}') do |deuda|
  @gasto = RepositorioGastos.new.find(@id_gasto)
  expect(@gasto.deuda_por_usuario).to eq deuda.to_i
end

Entonces('{string} debe pagar {string}') do |otro_usuario, deuda|
  expect(@gasto.deuda_por_usuario).to eq deuda.to_i
end
