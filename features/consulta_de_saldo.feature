# language: es
Característica: Como usuario quiero poder consultar mi saldo actual en la aplicación

  Escenario: 2.1 Usuario registrado con saldo 0 consulta su saldo
    Dado que soy un usuario registrado con saldo "0"
    Cuando quiero consultar mi saldo
    Entonces veo en saldo "0"

  @wip
  Escenario: 2.2 Usuario registrado con saldo 500 consulta su saldo
    Dado que soy un usuario registrado con saldo "500"
    Cuando quiero consultar mi saldo
    Entonces veo en saldo "500"
