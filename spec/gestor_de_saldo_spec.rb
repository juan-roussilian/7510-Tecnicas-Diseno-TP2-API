require 'spec_helper'
require './dominio/gestor_de_saldo'

def crear_billetera_con_saldo(saldo)
  gestor = GestorDeSaldo.new(nil)
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
      gestor = crear_billetera_con_saldo(10)
      gestor.cargar_saldo(500)
      expect(gestor.saldo).to eq 510
    end
    it 'dado un saldo 10 quiero cargar -10 obtengo 10' do
      gestor = crear_billetera_con_saldo(10)
      gestor.cargar_saldo(-10)
      expect(gestor.saldo).to eq 10
    end
    it 'dado un saldo 10 quiero cargar 0 obtengo 10' do
      gestor = crear_billetera_con_saldo(10)
      gestor.cargar_saldo(0)
      expect(gestor.saldo).to eq 10
    end
  end

  describe 'transferir' do
    it 'dado un saldo 50 quiero transferir 10 obtengo 40' do
      billetera = crear_billetera_con_saldo(50)
      usuario = MockUsuario.new(0)
      billetera.transferir(usuario, 10)
      expect(billetera.saldo).to eq 40
    end
    it 'dado un saldo 50 quiero transferir 10 y el receptor obtiene 10' do
      billetera = crear_billetera_con_saldo(50)
      usuario = MockUsuario.new(0)
      billetera.transferir(usuario, 10)
      expect(usuario.saldo).to eq 10
    end
    it 'dado un saldo 50 y un receptor con saldo 100 quiero transferir 20 y el receptor obtiene 120' do
      billetera = crear_billetera_con_saldo(50)
      usuario = MockUsuario.new(100)
      billetera.transferir(usuario, 20)
      expect(usuario.saldo).to eq 120
    end
    it 'dado un saldo 50 y un receptor con saldo 100 quiero transferir 51 y emite excepcion' do
      billetera = crear_billetera_con_saldo(50)
      usuario = MockUsuario.new(100)
      begin
        billetera.transferir(usuario, 51)
      rescue SaldoInsuficiente
        expect(usuario.saldo).to eq 100
      else
        expect(false).to eq true
      end
    end
  end
end

class MockUsuario
  def initialize(saldo)
    @saldo = crear_billetera_con_saldo(saldo)
  end

  def cargar_saldo(monto)
    @saldo.cargar_saldo(monto)
  end

  def saldo
    @saldo.saldo
  end
end
