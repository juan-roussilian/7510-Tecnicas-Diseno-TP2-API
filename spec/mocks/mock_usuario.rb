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
