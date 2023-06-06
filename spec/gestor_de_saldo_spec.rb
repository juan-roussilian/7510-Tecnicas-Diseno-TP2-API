require 'spec_helper'
require './dominio/gestor_de_saldo'

describe GestorDeSaldo do
  describe 'cargar saldo' do
    it 'dado un saldo 0 quiero cargar 500 obtengo 500' do
      expect(described_class.new.cargar_saldo(0, 500)).to eq 500
    end
    it 'dado un saldo 10 quiero cargar 500 obtengo 510' do
      expect(described_class.new.cargar_saldo(10, 500)).to eq 510
    end
    it 'dado un saldo 10 quiero cargar -10 obtengo 10' do
      expect(described_class.new.cargar_saldo(10, -10)).to eq 10
    end
    it 'dado un saldo 10 quiero cargar 0 obtengo 10' do
      expect(described_class.new.cargar_saldo(10, -10)).to eq 10
    end
  end
end
