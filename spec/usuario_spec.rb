require 'spec_helper'

describe Usuario do
  describe 'pruebas de saldo' do
    it 'usuario nuevo contiene saldo 0' do
      usuario = described_class.new('nuevo usuario', 'test@test.com')
      expect(usuario.saldo).to eq 0
    end

    it 'usuario nuevo carga 500 saldo 500' do
      usuario = described_class.new('nuevo usuario', 'test@test.com')
      usuario.cargar_saldo(500)
      expect(usuario.saldo).to eq 500
    end

    it 'usuario con 10 carga 500 saldo 510' do
      usuario = described_class.new('nuevo usuario', 'test@test.com')
      usuario.cargar_saldo(10)
      usuario.cargar_saldo(500)
      expect(usuario.saldo).to eq 510
    end

    it 'usuario no puede cargar saldo negativo' do
      usuario = described_class.new('nuevo usuario', 'test@test.com')
      usuario.cargar_saldo(-10)
      expect(usuario.saldo).to eq 0
    end

    it 'usuario (con carga) no puede cargar saldo negativo' do
      usuario = described_class.new('nuevo usuario', 'test@test.com')
      usuario.cargar_saldo(500)
      usuario.cargar_saldo(-10)
      expect(usuario.saldo).to eq 500
    end
  end
end
