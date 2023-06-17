class MovimientoPagoDeGasto
  attr_reader :usuario, :monto, :gasto, :usuario_pagador

  def initialize(usuario, monto, gasto, usuario_pagador)
    @usuario = usuario
    @monto = monto
    @gasto = gasto
    @usuario_pagador = usuario_pagador
  end
end
