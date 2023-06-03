When('que soy un usuario registrado con saldo "{int}"') do |saldo|
  # RepositorioUsuarios.new.save(usuario_de_prueba(saldo))
  request_body = { nombre: 'Juan', email: 'juan@test.com' }.to_json
  Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
  @mail = 'juan@test.com'
end

When(/^quiero consultar mi saldo$/) do
  @response = Faraday.get('/usuarios')
  @usuario = JSON.parse(@response.body)
  # for elemento in JSON.parse(@response.body)
  #   if elemento['email'] == @mail
  #     next
  #   end
  #   @usuario = elemento
  #   break
  # end
end

When('veo en saldo "{int}"') do |saldo_esperado|
  expect(@usuario[0]['saldo']).to eq saldo_esperado
end
