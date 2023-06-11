require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../persistencia/repositorio_usuarios'
require_relative '../../persistencia/repositorio_grupos'

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

  it 'deberia recuperar un usuario mediante su grupo' do
    repositorio = described_class.new
    carlos = Usuario.new('carlos', 'carlos@test.com', 'telegramId', 'carlosTest')
    juan = Usuario.new('juan', 'juan@test.com', 'telegramId2', 'juanTest')
    repositorio.save(carlos)
    repositorio.save(juan)
    repositorio_grupos = RepositorioGrupos.new
    repositorio_grupos.delete_all
    repositorio_grupos.save(Grupo.new('grupo', [carlos, juan]))
    usuarios_recuperados = repositorio.find_by_group_name('grupo')
    ids_usuarios_recuperados = usuarios_recuperados.map(&:id)
    expect(ids_usuarios_recuperados).to contain_exactly(juan.id, carlos.id)
  end
end
