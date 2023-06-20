# language: es
Característica: Como usuario quiero que, al transferir dinero a un usuario, se me notifique mediante un correo de la transferencia realizada

  @local
  Escenario: 13.1 Usuario registrado transfiere saldo se le notifica por mail
    Dado que soy un usuario registrado con mail "jroussilian@fi.uba.ar"
    Y existe un usuario con el nombre "juancho"
    Cuando quiero transferir 50 al usuario registrado "juancho"
    Entonces se me notifica que transferí 50 a "juan"

  @local
  Escenario: 13.2 Usuario registrado transfiere saldo se le notifica por mail
    Dado que soy un usuario registrado con mail "jroussilian@fi.uba.ar"
    Y existe un usuario con el nombre "nicolas"
    Cuando quiero transferir 200.3 al usuario registrado "nicolas"
    Entonces se me notifica que transferí 200.3 a "nicolas"
