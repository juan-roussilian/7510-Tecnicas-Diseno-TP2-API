# language: es
Característica: Como Usuario quiero que la app me permita pagar un gasto equitativo de mi grupo

  @wip @local
  Escenario: 12.1 Usuario en un grupo de 4 personas paga un gasto equitativo
    Dado que soy un usuario registrado y poseo saldo 500
    Y estoy en un grupo con "juan", "pedro" y "lucas"
    Y el grupo tiene un gasto equitativo para pagar de "100"
    Cuando quiero pagar el gasto del grupo
    Entonces veo que pago "25"
    Y mi saldo pasa a ser 475

  @wip @local
  Escenario: 12.2 Usuario en un grupo de 2 personas paga un gasto equitativo
    Dado que soy un usuario registrado y poseo saldo 75
    Y estoy en un grupo con "juan"
    Y el grupo tiene un gasto equitativo para pagar de "150"
    Cuando quiero pagar el gasto del grupo
    Entonces veo que pago "75"
    Y mi saldo pasa a ser 0
