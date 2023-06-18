class MockUsuario
  def initialize(saldo)
    @saldo = crear_billetera_con_saldo(saldo)
  end

  def cargar_saldo(monto, repositorio_usuarios = nil, repositorio_movimientos = nil)
    @saldo.cargar_saldo(monto, repositorio_usuarios, repositorio_movimientos)
  end

  def saldo
    @saldo.saldo
  end
end

class MockUsuarioSinBilletera
  def nombre
    'test'
  end

  def id
    nil
  end
end
