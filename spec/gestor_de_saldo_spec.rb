require 'spec_helper'
require './dominio/gestor_de_saldo'

def crear_gestor_con_saldo(saldo)
  gestor = described_class.new(nil)
  gestor.cargar_saldo(saldo)
  gestor
end

describe GestorDeSaldo do
  describe 'cargar saldo' do
    it 'nuevo gestor tiene saldo 0' do
      gestor = described_class.new(nil)
      expect(gestor.saldo).to eq 0
    end
    it 'dado un saldo 0 quiero cargar 500 obtengo 500' do
      gestor = described_class.new(nil)
      gestor.cargar_saldo(500)
      expect(gestor.saldo).to eq 500
    end
    it 'dado un saldo 10 quiero cargar 500 obtengo 510' do
      gestor = crear_gestor_con_saldo(10)
      gestor.cargar_saldo(500)
      expect(gestor.saldo).to eq 510
    end
    it 'dado un saldo 10 quiero cargar -10 obtengo 10' do
      gestor = crear_gestor_con_saldo(10)
      gestor.cargar_saldo(-10)
      expect(gestor.saldo).to eq 10
    end
    it 'dado un saldo 10 quiero cargar 0 obtengo 10' do
      gestor = crear_gestor_con_saldo(10)
      gestor.cargar_saldo(0)
      expect(gestor.saldo).to eq 10
    end
  end
end
