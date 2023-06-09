require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../persistencia/repositorio_usuarios'

describe RepositorioUsuarios do
  it 'deberia guardar y asignar id si el usuario es nuevo' do
    juan = Usuario.new('juan', 'juan@test.com', 'unId', 'carlos')
    described_class.new.save(juan)
    expect(juan.id).not_to be_nil
  end

  it 'deberia recuperar todos' do
    repositorio = described_class.new
    cantidad_de_usuarios_iniciales = repositorio.all.size
    juan = Usuario.new('juan', 'juan@test.com', 'unId', 'carlos')
    repositorio.save(juan)
    expect(repositorio.all.size).to be(cantidad_de_usuarios_iniciales + 1)
  end

  it 'deberia recuperar un usuario mediante su id de telegram' do
    repositorio = described_class.new
    carlos = Usuario.new('carlos', 'carlos@test.com', 'Id', 'carlos')
    repositorio.save(carlos)
    usuario_recuperado = repositorio.find_by_telegram_id(carlos.telegram_id)
    expect(usuario_recuperado.id).to eq(carlos.id)
  end

  it 'deberia recuperar un usuario mediante su nombre de telegram' do
    repositorio = described_class.new
    carlos = Usuario.new('carlos', 'carlos@test.com', 'telegramId', 'carlostest')
    repositorio.save(carlos)
    usuario_recuperado = repositorio.find_by_telegram_username(carlos.telegram_username)
    expect(usuario_recuperado.id).to eq(carlos.id)
  end
end
