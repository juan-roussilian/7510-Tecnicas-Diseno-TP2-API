# language: es
Característica: Como usuario quiero poder cargar saldo para usar en la aplicación

  Escenario: 3.1 Usuario carga saldo positivo para un usuario existente y la aplicación lo suma a su saldo
    Dado que soy un usuario con saldo "0"
    Cuando quiero cargar saldo "500"
    Entonces mi saldo pasa a ser "500"

  Escenario: 3.2 Usuario carga saldo positivo para un usuario existente y la aplicación lo suma a su saldo
    Dado que soy un usuario con saldo "200"
    Cuando quiero cargar saldo "500"
    Entonces mi saldo pasa a ser "700"

    @wip
  Escenario: 3.3 Usuario carga saldo negativo para un usuario existente y la aplicación no lo modifica
    Dado que soy un usuario con saldo "1000"
    Cuando quiero cargar saldo "-500"
    Entonces mi saldo pasa a ser "1000"
