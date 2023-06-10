require 'spec_helper'
require './dominio/grupo'

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
end

class MockRepositorioUsuarios
  def initialize
    @users = []
  end

  def find_by_telegram_username(telegram_username)
    user = @users.find { |u| u.telegram_username == telegram_username }
    raise ObjectNotFound.new(self.class.model_class, telegram_username) if user.nil?

    user
  end

  def save(user)
    @users << user
  end

  def load_example_users(number_of_users)
    (0..number_of_users).each do |i|
      save(Usuario.new("usuario#{i}", "test#{i}@test.com", i.to_s, "user#{i}"))
    end
  end
end
