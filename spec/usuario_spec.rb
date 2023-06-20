require 'spec_helper'
require 'dotenv/load'
require './spec/mocks/mock_bonificador_exitoso'

describe Usuario do
  describe 'pruebas de saldo' do
    it 'usuario nuevo contiene saldo 0' do
      usuario = described_class.new('nuevo usuario', 'test@test.com', 'unId', 'username')
      expect(usuario.saldo).to eq 0
    end

    it 'usuario nuevo carga 500 saldo 500' do
      usuario = described_class.new('nuevo usuario', 'test@test.com', 'unId', 'username')
      usuario.cargar_saldo(500, MockRepositorioUsuarios.new)
      expect(usuario.saldo).to eq 500
    end

    it 'usuario con 10 carga 500 saldo 510' do
      usuario = described_class.new('nuevo usuario', 'test@test.com', 'unId', 'username')
      repo_usuarios_mock = MockRepositorioUsuarios.new
      usuario.cargar_saldo(10, repo_usuarios_mock)
      usuario.cargar_saldo(500, repo_usuarios_mock)
      expect(usuario.saldo).to eq 510
    end

    it 'usuario no puede cargar saldo negativo' do
      usuario = described_class.new('nuevo usuario', 'test@test.com', 'unId', 'username')
      begin
        usuario.cargar_saldo(-10, MockRepositorioUsuarios.new)
      rescue CargaNegativa
        expect(usuario.saldo).to eq 0
      else
        expect(false).to eq true
      end
    end

    it 'usuario (con carga) no puede cargar saldo negativo' do
      usuario = described_class.new('nuevo usuario', 'test@test.com', 'unId', 'username')
      usuario.cargar_saldo(500, MockRepositorioUsuarios.new)
      begin
        usuario.cargar_saldo(-10, MockRepositorioUsuarios.new)
      rescue CargaNegativa
        expect(usuario.saldo).to eq 500
      else
        expect(false).to eq true
      end
      expect(usuario.saldo).to eq 500
    end

    it 'usuario con bonificador exitoso debe cargar saldo con bonificacion del 10%' do
      usuario = described_class.new('nuevo usuario', 'test@test.com', 'unId', 'username')
      bonificador = MockBonificadorExitoso.new(ENV['COEFICIENTE_BONIFICACION'].to_f)
      usuario.cargar_saldo(500, MockRepositorioUsuarios.new, bonificador:)
      expect(usuario.saldo).to eq 550
    end
  end
end
