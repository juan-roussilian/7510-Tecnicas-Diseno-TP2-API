# language: es
Característica: Como usuario quiero poder transferir saldo a otros usuarios

  @wip @local
  Escenario: 4.1 Usuario registrado con saldo suficiente transfiere todo su saldo a otro usuario registrado sin saldo
    Dado que soy un usuario registrado con saldo "500"
    Y existe un usuario con el mail "juan@test.com"
    Cuando quiero transferir "500" al usuario registrado de mail "juan@test.com" con saldo "0"
    Entonces mi saldo pasa a ser "0"
    Y el saldo de "juan" es "500"

  @wip @local
  Escenario: 4.2 Usuario registrado con saldo suficiente transfiere parte de su saldo a otro usuario registrado sin saldo
    Dado que soy un usuario registrado con saldo "500"
    Y existe un usuario con el mail "juan@test.com"
    Cuando quiero transferir "100" al usuario registrado de mail "juan@test.com" con saldo "0"
    Entonces mi saldo pasa a ser "400"
    Y el saldo de "juan" es "100"

  @wip @local
  Escenario: 4.3 Usuario registrado con saldo suficiente transfiere parte de su saldo a otro usuario registrado con saldo preexistente
    Dado que soy un usuario registrado con saldo "500"
    Y existe un usuario con el mail "juan@test.com"
    Cuando quiero transferir "200" al usuario registrado de mail "juan@test.com" con saldo "1000"
    Entonces mi saldo pasa a ser "300"
    Y el saldo de "juan@test.com" es "1200"
