require 'spec_helper'
require './dominio/grupo'
require './spec/mocks/mock_repositorio_usuarios'

def crear_grupo_con_usuarios(nombre, cantidad, repositorio_usuarios, repositorio_grupos = nil)
  repositorio_usuarios.load_example_users(cantidad)
  usuarios = []
  cantidad.times do |i|
    usuarios << repositorio_usuarios.find_by_telegram_username("user#{i + 1}")
  end
  Grupo.new(nombre, usuarios, repositorio_grupos)
end

describe Grupo do
  describe 'new' do
    it 'dado un nombre de grupo y dos usuarios puedo crear un grupo' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      grupo = crear_grupo_con_usuarios('nombre', 2, repositorio_usuarios)
      expect(grupo.nombre).to eq 'nombre'
      lista_usuarios = []
      grupo.usuarios.each do |usuario|
        lista_usuarios << usuario.telegram_username
      end
      expect(lista_usuarios).to contain_exactly('user1', 'user2')
    end

    it 'dado un nombre de grupo y un usuario no puedo crear un grupo' do
      repositorio_usuarios = MockRepositorioUsuarios.new
      expect do
        crear_grupo_con_usuarios('grupo', 1, repositorio_usuarios)
      end.to raise_error(MiembrosInsuficientesParaGrupo)
    end
  end

  it 'el nuevo grupo debe tener nombre unico en el repositorio de grupos si no lanza excepcion' do
    repositorio_grupos = RepositorioGrupos.new
    repositorio_grupos.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    grupo = crear_grupo_con_usuarios('grupoTest', 3, repositorio_usuarios, repositorio_grupos)
    repositorio_grupos.save(grupo)
    expect(repositorio_grupos.all.size).to eq 1
    expect do
      crear_grupo_con_usuarios('grupoTest', 2, repositorio_usuarios, repositorio_grupos)
    end.to raise_error(NombreDeGrupoRepetido)
  end

  it 'el usuario esta en el grupo' do
    repositorio_grupos = RepositorioGrupos.new
    repositorio_grupos.delete_all
    repositorio_usuarios = MockRepositorioUsuarios.new
    cantidad = 3
    repositorio_usuarios.load_example_users(cantidad)
    usuarios = []
    cantidad.times do |i|
      usuarios << repositorio_usuarios.find_by_telegram_username("user#{i + 1}")
    end
    grupo = Grupo.new('grupoTest', usuarios, repositorio_grupos)
    repositorio_grupos.save(grupo)
    expect(grupo.es_miembro(usuarios[0].telegram_username)).to eq true
    expect(grupo.es_miembro('asd')).to eq false
  end
end
