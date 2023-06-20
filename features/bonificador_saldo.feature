# language: es

Característica: Como usuario quiero recibir un obsequio del 10% al cargar saldo si el dia es domingo y el clima lluvia
  @wip
  Escenario: 22.1 Cargar saldo dia domingo con lluvia carga con obsequio
    Dado que soy un usuario registrado con saldo "0"
    Y el dia es "domingo"
    Y el clima es "lluvia"
    Cuando quiero cargar saldo "563"
    Entonces mi saldo es de 619.3

  @wip
  Escenario: 22.2 Cargar saldo dia que no es domingo con lluvia carga sin obsequio

    Dado que soy un usuario registrado con saldo "1000"
    Y el dia es "jueves"
    Y el clima es "lluvia"
    Cuando quiero cargar saldo"200.5"
    Entonces mi saldo es de "1200.5"
 
  @wip
  Escenario: 22.3 Cargar saldo dia domingo sin clima de lluvia carga sin obsequio

    Dado que soy un usuario registrado con saldo "60"
    Y el dia es "domingo"
    Y el clima es "soleado"
    Cuando quiero cargar saldo "5"
    Entonces mi saldo es de "65"
 
  @wip
  Escenario: 22.4 Cargar saldo dia que no es domingo sin clima de lluvia carga sin obsequio

    Dado que soy un usuario registrado con saldo "580"
    Y el dia es "martes"
    Y el clima es "soleado"
    Cuando quiero cargar saldo "420"
    Entonces mi saldo es de 1000