require './dominio/proveedor_clima'
require './spec/mocks/mock_consultor_clima_lluvioso'
require './spec/mocks/mock_consultor_clima_sin_lluvia'

describe ProveedorClima do
  describe 'consultar clima lluvioso' do
    it 'consultar si el clima es lluvioso para precipitacion mayor o igual a 0.5mm es true' do
      proveedor = described_class.new(MockConsultorClimaLluvioso.new)
      expect(proveedor.llueve?).to eq true
    end
    it 'consultar si el clima es lluvioso para precipitacion menor 0.5mm es false' do
      proveedor = described_class.new(MockConsultorClimaSinLluvia.new)
      expect(proveedor.llueve?).to eq false
    end
  end
end
