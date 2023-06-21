require './dominio/bonificador'
require 'webmock'
require 'dotenv/load'

describe Bonificador do
  describe 'aplicar bonificacion segun clima y dia' do
    it 'dia domingo con lluvia intensa deberia dar bonificacion del 10%' do
      saldo_inicial = 600.7
      proveedor_fecha = ProveedorFecha.new('2023-06-18')
      proveedor_clima = ProveedorClima.new(MockConsultorClimaLluvioso.new)
      bonificador = described_class.new(proveedor_fecha, proveedor_clima)
      saldo_bonificado = bonificador.aplicar_bonificacion_segun_clima_y_dia(saldo_inicial)
      expect(saldo_bonificado).to eq(saldo_inicial * 1.1)
    end
  end
end
