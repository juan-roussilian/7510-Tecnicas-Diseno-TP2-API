Dado('estoy en un grupo con {string}') do |nombre_otro_usuario|
  repositorio_usuarios = RepositorioUsuarios.new
  repositorio_usuarios.delete_all
  @otro_usuario = Usuario.new('user', 'userprueba@test.com', 'IdTelegram', nombre_otro_usuario)
  repositorio_usuarios.save(@otro_usuario)
  repositorio_grupos = RepositorioGrupos.new
  repositorio_grupos.delete_all
  @grupo = Grupo.new('grupo', [@usuario, @otro_usuario], repositorio_grupos)
  repositorio_grupos.save(@grupo)
end

Cuando('quiero crear un gasto equitativo de {string} con el nombre {string}') do |monto, nombre_gasto|
  request_body = { usuario: @usuario.telegram_id, nombre_gasto:, monto:, nombre_grupo: @grupo.nombre }.to_json
  @response = Faraday.post(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
end

Entonces('veo el mensaje {string} con id numerico') do |string|
  expect(@response.body).to eq string
end

Entonces('debo pagar {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('{string} debe pagar {string}') do |string, string2|
  pending # Write code here that turns the phrase above into concrete actions
end
