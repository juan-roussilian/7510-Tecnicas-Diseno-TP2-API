class MovimientoPagoDeGasto
  attr_reader :gasto

  def initialize(usuario, monto, gasto, usuario_pagador)
    @usuario = usuario
    @monto = monto
    @gasto = gasto
    @usuario_pagador = usuario_pagador
  end
end
