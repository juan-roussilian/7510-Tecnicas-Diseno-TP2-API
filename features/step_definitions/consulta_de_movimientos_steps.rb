Dado('no tengo movimientos') do
end

Cuando('quiero consultar mis movimientos') do
  @movimientos = JSON.parse(Faraday.get(get_url_for('/movimientos'),{ usuario: @respuesta['telegram_id'] } ).body)
end

Entonces('veo que no tengo movimientos') do
  expect(@movimientos).to eq ''
end

Dado('tengo un movimiento del tipo carga saldo') do
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('veo que tengo los {int} movimientos') do |int|
  pending # Write code here that turns the phrase above into concrete actions
end
