# language: es
Característica: Como usuario quiero poder consultar mi saldo actual en la aplicación
  
  @local
  Escenario: 2.1 Usuario registrado con saldo 0 consulta su saldo
    Dado que soy un usuario registrado con saldo "0"
    Cuando quiero consultar mi saldo
    Entonces veo en saldo "0"

  @local
  Escenario: 2.2 Usuario registrado con saldo 500 consulta su saldo
    Dado que soy un usuario registrado con saldo "500"
    Cuando quiero consultar mi saldo
    Entonces veo en saldo "500"
  
  Escenario: 2.3 Usuario registrado con saldo 0 consulta su saldo
    Dado que soy un nuevo usuario registrado
    Cuando consulto mi saldo
    Entonces veo en saldo "0"

  Escenario: 2.4 Usuario registrado con saldo 500 consulta su saldo
    Dado que soy un nuevo usuario registrado
    Y cargo saldo "500"
    Cuando consulto mi saldo
    Entonces veo en saldo "500"
