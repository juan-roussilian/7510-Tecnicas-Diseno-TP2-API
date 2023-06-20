
Cuando('quiero crear un gasto a la gorra de {string} con el nombre {string}') do |monto, nombre_gasto|
  request_body = { usuario: @usuario.telegram_id, nombre_gasto:, monto:, nombre_grupo: @grupo.nombre, tipo: 'gorra' }.to_json
  @respuesta = Faraday.post(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
end

Dado(/^el grupo tiene un gasto a la gorra para pagar de "([^"]*)"$/) do |monto|
  usuario = RepositorioUsuarios.new.find_by_telegram_username(@usuario.telegram_username)
  request_body = { usuario: usuario.telegram_id, nombre_gasto: 'gasto_gorra_test', monto:, nombre_grupo: @grupo.nombre, tipo: 'gorra' }.to_json
  respuesta_gasto = Faraday.post(get_url_for('/gasto'), request_body, { 'Content-Type' => 'application/json' })
  @id = JSON.parse(respuesta_gasto.body)['id']
  @gasto = RepositorioGastos.new.find(@id)
end

When(/^el resto del grupo debe (\d+)$/) do |monto|
  expect(@gasto.deuda_por_usuario).to eq monto.to_i
end
