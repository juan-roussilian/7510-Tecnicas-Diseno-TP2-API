When(/^el grupo tiene un gasto equitativo para pagar de "([^"]*)"$/) do |monto|
  request_body = { usuario: @usuario.telegram_id, nombre_gasto: 'gasto_equitativo_test', monto:, nombre_grupo: @grupo.nombre }.to_json
  respuesta_gasto = Faraday.post(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
  @id = JSON.parse(respuesta_gasto.body)['id']
end

When(/^quiero pagar el gasto del grupo$/) do
  request_body = { usuario: @usuario.telegram_username, id_gasto: @id, monto: @usuario.saldo }.to_json
  @respuesta = Faraday.get(get_url_for('/pagar-gasto'), request_body, { 'Content-Type' => 'application/json' })
end

When(/^veo que pago "([^"]*)"$/) do |monto|
  pending
end
