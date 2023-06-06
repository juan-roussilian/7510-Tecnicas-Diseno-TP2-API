def usuario_de_prueba(saldo)
  usuario = Usuario.new('Juan', 'juan@test.com')
  usuario.cargar_saldo(saldo)
  usuario
end

Dado('que soy un usuario registrado con saldo "{int}"') do |saldo|
  @usuario = usuario_de_prueba(saldo)
  RepositorioUsuarios.new.save(@usuario)
  # request_body = { nombre: 'Juan', email: 'juan@test.com' }.to_json
  # carga_de_usuario = Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' })
  # @mail = 'juan@test.com'
  # usuario = RepositorioUsuarios.new.find(JSON.parse(carga_de_usuario.body)['id'])
  # usuario.cargar_saldo(saldo)
end

Cuando(/^quiero consultar mi saldo$/) do
  # @response = Faraday.get('/usuarios')
  # @usuario = JSON.parse(@response.body)
  # for elemento in JSON.parse(@response.body)
  #   if elemento['email'] == @mail
  #     next
  #   end
  #   @usuario = elemento
  #   break
  # end
  @saldo = @usuario.saldo
end

Entonces('veo en saldo "{int}"') do |saldo_esperado|
  # expect(@usuario[0]['saldo']).to eq saldo_esperado
  expect(@saldo).to eq saldo_esperado
end

Dado('que soy un nuevo usuario registrado') do
  request_body = { nombre: 'Juan', email: 'juan@test.com' }.to_json
  @carga_de_usuario = JSON.parse(
    Faraday.post('/usuarios', request_body, { 'Content-Type' => 'application/json' }).body
  )
end

Cuando('consulto mi saldo') do
  @usuario = RepositorioUsuarios.new.find(@carga_de_usuario['id'])
  @saldo = @usuario.saldo
end

Dado('cargo saldo "{int}"') do |saldo|
  @usuario = RepositorioUsuarios.new.find(@carga_de_usuario['id'])
  @usuario.cargar_saldo(saldo)
end
