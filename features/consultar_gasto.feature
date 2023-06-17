# language: es
Característica: Como usuario quiero consultar los gastos de un grupo mediante el id de gasto

  @local
  Escenario: 10.1 Usuario registrado quiere consultar sus gastos
    Dado que me registre
    Y estoy en un grupo que tiene gasto con un id
    Cuando quiero consultar los detalles del gasto con el id del gasto
    Entonces veo el detalle del gasto
