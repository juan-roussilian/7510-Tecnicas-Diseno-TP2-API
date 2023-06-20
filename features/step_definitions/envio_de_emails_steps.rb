require 'mail'
require 'byebug'

Dado('que soy un usuario registrado con mail {string}') do |mail|
  @mail = mail
  repo_usuarios = RepositorioUsuarios.new
  repo_usuarios.delete_all
  request_body = { nombre: 'nombre', email: mail, telegram_id: '1', telegram_username: 'user'}.to_json
  respuesta = JSON.parse(Faraday.post(get_url_for('/usuarios'), request_body, { 'Content-Type' => 'application/json' }).body)
  @usuario = repo_usuarios.find(respuesta['id'])
  @usuario.cargar_saldo(1000,repo_usuarios)
end

Entonces('se me notifica que transferí {float} a {string}') do |monto, nombre|
  archivo = File.open("./testmail/#{@mail}")
  contenido = archivo.read
  expect(contenido.include?(monto.to_s)).to eq true
  expect(contenido.include?(nombre)).to eq true
end
