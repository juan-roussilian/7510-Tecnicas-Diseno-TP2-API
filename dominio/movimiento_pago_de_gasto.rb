require_relative './movimiento'

class MovimientoPagoDeGasto < Movimiento
  attr_reader :usuario, :monto, :gasto, :usuario_pagador
  attr_accessor :id

  def initialize(usuario, monto, gasto, usuario_pagador, id: nil)
    @gasto = gasto
    @usuario_pagador = usuario_pagador
    super(usuario, monto, id:)
  end

  def obtener_changeset
    changes = super
    changes[:tipo] = 'pago gasto'
    changes[:id_usuario_secundario] = @usuario_pagador.id
    changes[:id_gasto] = @gasto.id
    changes
  end
end
