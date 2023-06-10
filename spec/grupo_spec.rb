require 'spec_helper'
require './dominio/grupo'

describe Grupo do
  describe 'new' do
    it 'dado un nombre de grupo y dos usuarios puedo crear un grupo' do
      repo = MockRepositorioUsuarios.new
      repo.load_example_users
      grupo = Grupo.new('nombre', %w[juan pedro], repo)
      expect(grupo.nombre).to eq 'nombre'
      lista_usuarios = []
      grupo.usuarios.each do |usuario|
        lista_usuarios << usuario.telegram_username
      end
      expect(lista_usuarios).to contain_exactly('juan', 'pedro')
    end
  end
end

class MockRepositorioUsuarios
  def initialize
    @usuarios = []
  end

  def find_by_telegram_username(telegram_username)
    usuario = @usuarios.find { |u| u.telegram_username == telegram_username }
    raise ObjectNotFound.new(self.class.model_class, telegram_username) if usuario.nil?

    usuario
  end

  def save(usuario)
    @usuarios << usuario
  end

  def load_example_users
    save(Usuario.new('nuevo usuario', 'test@test.com', 'unId', 'juan'))
    save(Usuario.new('otro usuario', 'test2@test.com', 'otroId', 'pedro'))
  end
end
