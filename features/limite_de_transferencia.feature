# language: es
Característica: Como usuario no puedo transferir mas saldo del que poseo

  Escenario: 7.1 Usuario registrado quiere transferir mas saldo del que posee
    Dado que soy un usuario registrado y poseo saldo 500
    Y existe un usuario con el nombre de telegram "juan" con saldo 10
    Cuando quiero transferir 501 al usuario registrado "juan"
    Entonces veo que no se puede transferir
    Y mi saldo pasa a ser 500
    Y el saldo del usuario al que le transferi es de 10
