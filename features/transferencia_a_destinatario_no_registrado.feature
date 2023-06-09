# language: es
Característica: Como usuario no puedo transferir a un usuario no registrado

  Escenario: 20.1 Usuario registrado quiere transferir mas saldo del que posee
    Dado que soy un usuario registrado y poseo saldo 500
    Y no existe un usuario con el nombre de telegram "@juan"
    Cuando quiero transferir 500 al usuario registrado "@juan"
    Entonces veo que no se puede transferir
    Y mi saldo pasa a ser 500
