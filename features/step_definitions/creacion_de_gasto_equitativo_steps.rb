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
  @respuesta = Faraday.post(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
end

Entonces('veo el mensaje {string} con id numerico') do |mensaje|
  response_body = @respuesta.body
  mensaje_expected = response_body[/^(#{Regexp.escape(mensaje)})/]
  @id_gasto = response_body.scan(/\d+/).first.to_i
  expect(mensaje_expected).to eq mensaje
end

Entonces('debo pagar {string}') do |deuda|
  @gasto = RepositorioGastos.new.find(@id_gasto)
  expect(@gasto.deuda_por_usuario).to eq deuda.to_i
end

Entonces('{string} debe pagar {string}') do |otro_usuario, deuda|
  expect(@gasto.deuda_por_usuario).to eq deuda.to_i
end
