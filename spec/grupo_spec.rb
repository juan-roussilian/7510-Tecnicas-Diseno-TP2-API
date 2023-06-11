require 'spec_helper'
require './dominio/grupo'
require './spec/mocks/mock_repositorio_usuarios'

describe Grupo do
  describe 'new' do
    it 'dado un nombre de grupo y dos usuarios puedo crear un grupo' do
      repo = MockRepositorioUsuarios.new
      repo.load_example_users(2)
      grupo = Grupo.new('nombre', %w[user1 user2], repo)
      expect(grupo.nombre).to eq 'nombre'
      lista_usuarios = []
      grupo.usuarios.each do |usuario|
        lista_usuarios << usuario.telegram_username
      end
      expect(lista_usuarios).to contain_exactly('user1', 'user2')
    end

    it 'dado un nombre de grupo y un usuario no puedo crear un grupo' do
      repo = MockRepositorioUsuarios.new
      repo.load_example_users(1)
      expect { Grupo.new('nombre', %w[user1], repo) }.to raise_error(MiembrosInsuficientesParaGrupo)
    end
  end

  it 'el nuevo grupo debe tener nombre unico en el repositorio de grupos si no lanza excepcion' do
    repo_grupo = RepositorioGrupos.new
    repo_grupo.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    repositorio_usuarios.load_example_users(3)
    repo_grupo.save(Grupo.new('grupoTest', %w[user1 user2 user3], repositorio_usuarios, repo_grupo))
    expect(RepositorioGrupos.new.all.size).to eq 1
    expect do
      Grupo.new('grupoTest', %w[user1 user2], repositorio_usuarios, repo_grupo)
    end.to raise_error(NombreDeGrupoRepetido)
  end
end
