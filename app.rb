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
  usuarios.map { |u| respuesta << { email: u.email, id: u.id, saldo: u.saldo.to_i, telegram_id: u.telegram_id } }
  status 200
  respuesta.to_json
end

post '/usuarios' do
  @body ||= request.body.read
  parametros_usuario = JSON.parse(@body)
  usuario = Usuario.new(parametros_usuario['nombre'], parametros_usuario['email'], parametros_usuario['telegram_id'])
  RepositorioUsuarios.new.save(usuario)
  status 201
  { id: usuario.id, nombre: usuario.nombre, email: usuario.email, telegram_id: usuario.telegram_id }.to_json
end

get '/saldo' do
  telegram_id = params[:usuario]
  begin
    usuario = RepositorioUsuarios.new.find_by_telegram_id(telegram_id)
  rescue ObjectNotFound
    status 400
    { saldo: 'debe registrarse primero' }.to_json
  else
    status 200
    { usuario: usuario.id, saldo: usuario.saldo }.to_json
  end
end

post '/saldo' do
  @body ||= request.body.read
  parametros_usuario = JSON.parse(@body)
  usuario = RepositorioUsuarios.new.find_by_telegram_id(parametros_usuario['telegram_id'])
  usuario.cargar_saldo(parametros_usuario['saldo'])
end
