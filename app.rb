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
  RepositorioGrupos.new.delete_all
  status 200
end

get '/usuarios' do
  usuarios = RepositorioUsuarios.new.all
  respuesta = []
  usuarios.map do |u|
    respuesta << { email: u.email, id: u.id, saldo: u.saldo.to_i, telegram_id: u.telegram_id.to_s,
                   telegram_username: u.telegram_username }
  end
  status 200
  respuesta.to_json
end

post '/usuarios' do
  @body ||= request.body.read
  parametros_usuario = JSON.parse(@body)
  begin
    usuario = Usuario.new(parametros_usuario['nombre'], parametros_usuario['email'],
                          parametros_usuario['telegram_id'].to_s, parametros_usuario['telegram_username'])
  rescue EmailInvalido
    status 409
    { error: 'mail invalido' }.to_json
  else
    RepositorioUsuarios.new.save(usuario)
    status 201
    { id: usuario.id, nombre: usuario.nombre, email: usuario.email, telegram_id: usuario.telegram_id,
      telegram_username: usuario.telegram_username }.to_json
  end
end

get '/saldo' do
  telegram_id = params[:usuario]
  begin
    usuario = RepositorioUsuarios.new.find_by_telegram_id(telegram_id.to_s)
  rescue ObjectNotFound
    status 400
    { error: 'debe registrarse primero' }.to_json
  else
    status 200
    { usuario: usuario.id, saldo: usuario.saldo }.to_json
  end
end

post '/saldo' do
  @body ||= request.body.read
  parametros_usuario = JSON.parse(@body)
  begin
    usuario = RepositorioUsuarios.new.find_by_telegram_id(parametros_usuario['telegram_id'].to_s)
    usuario.cargar_saldo(parametros_usuario['saldo'])
  rescue ObjectNotFound
    status 400
    { error: 'debe registrarse primero' }.to_json
  rescue CargaNegativa
    status 400
    { error: 'se ha intentado cargar un valor negativo de saldo' }.to_json
  else
    status 200
    { saldo: usuario.saldo }.to_json
  end
end

post '/transferir' do
  @body ||= request.body.read
  parametros_usuario = JSON.parse(@body)
  begin
    usuario = RepositorioUsuarios.new.find_by_telegram_id(parametros_usuario['usuario'].to_s)
  rescue ObjectNotFound
    status 400
    { error: 'debe registrarse primero' }.to_json
  else
    begin
      destinatario = RepositorioUsuarios.new.find_by_telegram_username(parametros_usuario['destinatario'])
      usuario.transferir(destinatario, parametros_usuario['monto'])
    rescue ObjectNotFound
      status 400
      { error: 'destinatario no registrado' }.to_json
    rescue SaldoInsuficiente
      status 400
      { error: 'saldo insuficiente para llevar a cabo la operacion' }.to_json
    else
      status 200
      ''
    end
  end
end

post '/grupo' do
  @body ||= request.body.read
  parametros_grupo = JSON.parse(@body)
  begin
    usuarios = []
    repositorio_usuarios = RepositorioUsuarios.new
    parametros_grupo['usuarios'].each do |telegram_username|
      usuario = repositorio_usuarios.find_by_telegram_username(telegram_username)
      usuarios.push(usuario)
    end
    repositorio_grupos = RepositorioGrupos.new
    grupo = Grupo.new(parametros_grupo['nombre'], usuarios, repositorio_grupos)
    repositorio_grupos.save(grupo)
  rescue MiembrosInsuficientesParaGrupo
    status 400
    { error: 'miembros del grupo insuficiente para llevar a cabo la operacion' }.to_json
  rescue NombreDeGrupoRepetido
    status 400
    { error: 'nombre repetido no se puede llevar a cabo la operacion' }.to_json
  else
    status 201
    'Grupo creado'
  end
end

post '/gasto' do
  @body ||= request.body.read
  parametros_gasto = JSON.parse(@body)
  begin
    nombre = parametros_gasto['nombre']
    monto = parametros_gasto['monto']
    grupo = RepositorioGrupos.new.find_by_name(parametros_gasto['nombre_grupo'])
    creador = RepositorioUsuarios.new.find_by_telegram_id(parametros_gasto['usuario'].to_s)
    repositorio_gastos = RepositorioGastos.new
    gasto = GastoEquitativo.new(nombre, monto, grupo, creador)
    repositorio_gastos.save(gasto)
  rescue ObjectNotFound
    status 400
    { error: 'no se pudo crear el gasto' }.to_json
  rescue GrupoNoEncontrado
    status 400
    { error: 'no se pudo crear el gasto, no existe el grupo' }.to_json
  else
    status 201
    "Gasto creado id: #{gasto.id}"
  end
end
