class MockBonificadorExitoso
  def initialize(coeficiente_bonificacion)
    @coeficiente_bonificacion = coeficiente_bonificacion
  end

  def aplicar_bonificacion_segun_clima_y_dia(saldo)
    saldo * @coeficiente_bonificacion
  end
end
