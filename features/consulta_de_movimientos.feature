# language: es
Característica: Como usuario quiero consultar mis movimientos
  @wip @local
  Escenario: 11.1 Usuario registrado quiere consultar mis movimientos
    Dado que soy un usuario registrado
    Y tengo un movimiento del tipo carga saldo
    Y tengo un movimiento del tipo transferencia 
    Y tengo un movimiento del tipo pago de gasto
    Cuando quiero consultar mis movimientos
    Entonces veo que tengo un movimiento de tipo "carga"
    Y veo que tengo un movimiento de tipo "transferencia"
    Y veo que tengo un movimiento de tipo "pago" 
  @wip
  Escenario: 11.2 Usuario registrado quiere consultar mis movimientos
    Dado que soy un usuario registrado
    Y no tengo movimientos
    Cuando quiero consultar mis movimientos
    Entonces veo que no tengo movimientos
