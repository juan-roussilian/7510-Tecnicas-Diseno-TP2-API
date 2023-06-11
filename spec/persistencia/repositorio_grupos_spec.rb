require 'integration_helper'
require_relative '../../dominio/grupo'
require_relative '../../persistencia/repositorio_grupos'
require './spec/mocks/mock_repositorio_usuarios'

describe RepositorioGrupos do
  it 'deberia guardar el grupo si es nuevo' do
    described_class.new.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    repositorio_usuarios.load_example_users(5)
    user1 = repositorio_usuarios.find_by_telegram_username('user1')
    user2 = repositorio_usuarios.find_by_telegram_username('user2')
    user3 = repositorio_usuarios.find_by_telegram_username('user3')
    grupo = Grupo.new('grupoTest', [user1, user2, user3])
    described_class.new.save(grupo)
    begin
      described_class.new.find_by_name('grupoTest')
    rescue GrupoNoEncontrado
      expect(false).to eq true
    else
      expect(true).to eq true
    end
  end

  it 'guardo un grupo nuevo se incrementa la cantidad de grupos en el repositorio' do
    described_class.new.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    repositorio_usuarios.load_example_users(2)
    user1 = repositorio_usuarios.find_by_telegram_username('user1')
    user2 = repositorio_usuarios.find_by_telegram_username('user2')
    grupo = Grupo.new('grupoTest', [user1, user2])
    described_class.new.save(grupo)
    expect(described_class.new.all.size).to eq 1
  end

  it 'deberia recuperar un grupo mediante su nombre' do
    described_class.new.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    repositorio_usuarios.load_example_users(2)
    user1 = repositorio_usuarios.find_by_telegram_username('user1')
    user2 = repositorio_usuarios.find_by_telegram_username('user2')
    grupo = Grupo.new('grupoTest', [user1, user2])
    repositorio = described_class.new
    repositorio.save(grupo)
    expect(repositorio.find_by_name('grupoTest').nombre).to eq 'grupoTest'
  end

  it 'guardo un grupo nuevo por tanto existe un grupo con dicho nombre' do
    described_class.new.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    repositorio_usuarios.load_example_users(2)
    user1 = repositorio_usuarios.find_by_telegram_username('user1')
    user2 = repositorio_usuarios.find_by_telegram_username('user2')
    grupo = Grupo.new('grupoTest', [user1, user2])
    described_class.new.save(grupo)
    expect(described_class.new.existe_grupo('grupoTest')).to eq true
  end
end
