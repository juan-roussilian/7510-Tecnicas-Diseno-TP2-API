# language: es
Característica: Como usuario quiero poder transferir saldo a otros usuarios


  Escenario: 4.1 Usuario registrado con saldo suficiente transfiere todo su saldo a otro usuario registrado sin saldo
    Dado que soy un usuario registrado y poseo saldo 500
    Y existe un usuario con el nombre "juan" con saldo 0
    Cuando quiero transferir 500 al usuario registrado "@juan"
    Entonces mi saldo pasa a ser 0
    Y el saldo del usuario al que le transferi es de 500

  @wip
  Escenario: 4.2 Usuario registrado con saldo suficiente transfiere parte de su saldo a otro usuario registrado sin saldo
    Dado que soy un usuario registrado con saldo "500"
    Y existe un usuario con el nombre "juan" con saldo 0
    Cuando quiero transferir 100 al usuario registrado "@juan"
    Entonces mi saldo pasa a ser 400
    Y el saldo del usuario al que le transferi es de 100

  @wip
  Escenario: 4.3 Usuario registrado con saldo suficiente transfiere parte de su saldo a otro usuario registrado con saldo preexistente
    Dado que soy un usuario registrado con saldo "500"
    Y existe un usuario con el nombre "juan" con saldo 1000
    Cuando quiero transferir 200 al usuario registrado "@juan"
    Entonces mi saldo pasa a ser 300
    Y el saldo del usuario al que le transferi es de 1200
