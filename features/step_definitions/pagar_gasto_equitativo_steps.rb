Dado(/^el grupo tiene un gasto equitativo para pagar de "([^"]*)"$/) do |monto|
  usuario = RepositorioUsuarios.new.find_by_telegram_username(@usuario.telegram_username)
  request_body = { usuario: usuario.telegram_id, nombre_gasto: 'gasto_equitativo_test', monto:, nombre_grupo: @grupo.nombre }.to_json
  respuesta_gasto = Faraday.post(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
  @id = JSON.parse(respuesta_gasto.body)['id']
end

Cuando(/^quiero pagar el gasto del grupo$/) do
  request_body = { usuario: @usuario.telegram_id, id_gasto: @id, monto: @usuario.saldo }
  @respuesta = Faraday.get(get_url_for('/cobrar-gasto'), request_body, { 'Content-Type' => 'application/json' })
end

Entonces(/^veo que pago "([^"]*)"$/) do |monto|
  expect(@respuesta.status).to eq 200
  respuesta = JSON.parse(@respuesta.body)
  expect(respuesta['cobro']).to eq monto.to_f
end
