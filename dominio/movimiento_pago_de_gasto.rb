require_relative './movimiento'

class MovimientoPagoDeGasto < Movimiento
  attr_reader :usuario, :monto, :gasto, :usuario_pagador
  attr_accessor :id

  def initialize(usuario, monto, gasto, usuario_pagador, id: nil)
    @gasto = gasto
    @usuario_pagador = usuario_pagador
    super(usuario, monto, id:)
  end

  def atributos_serializables
    atributos = super
    atributos[:tipo] = 'pago gasto'
    atributos[:id_usuario_secundario] = @usuario_pagador.id
    atributos[:id_gasto] = @gasto.id
    atributos
  end
end
