require './dominio/proveedor_fecha'

describe ProveedorFecha do
  describe 'consultar si fecha es dia domingo' do
    it 'consultar si es domingo para el dia  2023-06-18 deberia devolver true' do
      proveedor = described_class.new('2023-06-18')
      expect(proveedor.es_domingo?).to eq true
    end
    it 'consultar si es domingo para el dia  2023-06-20 deberia devolver false' do
      proveedor = described_class.new('2023-06-20')
      expect(proveedor.es_domingo?).to eq false
    end
  end
end
