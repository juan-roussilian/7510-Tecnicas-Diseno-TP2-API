require 'sinatra'
require 'sequel'
require 'sinatra/custom_logger'
require_relative './config/configuration'
require_relative './lib/version'
Dir[File.join(__dir__, 'dominio', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'persistencia', '*.rb')].each { |file| require file }

customer_logger = Configuration.logger
set :logger, customer_logger
DB = Configuration.db
DB.loggers << customer_logger

get '/version' do
  { version: Version.current }.to_json
end

post '/reset' do
  RepositorioUsuarios.new.delete_all
  status 200
end

get '/usuarios' do
  usuarios = RepositorioUsuarios.new.all
  respuesta = []
  usuarios.map { |u| respuesta << { email: u.email, id: u.id, saldo: u.saldo.to_i } }
  status 200
  respuesta.to_json
end

post '/usuarios' do
  @body ||= request.body.read
  parametros_usuario = JSON.parse(@body)
  usuario = Usuario.new(parametros_usuario['nombre'], parametros_usuario['email'], parametros_usuario['id'])
  RepositorioUsuarios.new.save(usuario)
  status 201
  { id: usuario.id, nombre: usuario.nombre, email: usuario.email }.to_json
end

get '/saldo' do
  id = params[:usuario]
  begin
    usuario = RepositorioUsuarios.new.find_by_id(id)
  rescue ObjectNotFound
    status 400
    { saldo: 'debe registrarse primero' }.to_json
  else
    status 200
    { usuario: usuario.id, saldo: usuario.saldo }.to_json
  end
end
