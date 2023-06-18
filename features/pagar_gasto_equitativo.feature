# language: es
Característica: Como Usuario quiero que la app me permita pagar un gasto equitativo de mi grupo

  @wip @local
  Escenario: 12.1 Usuario en un grupo de 4 personas paga un gasto equitativo
    Dado que soy un usuario registrado
    Y estoy en un grupo con "juan", "pedro" y "lucas"
    Y el grupo tiene un gasto equitativo para pagar de "100"
    Cuando quiero pagar el gasto del grupo
    Entonces veo que pago "25"

  @wip @local
  Escenario: 12.2 Usuario en un grupo de 5 personas paga un gasto equitativo
    Dado que soy un usuario registrado
    Y estoy en un grupo con "juan", "nico", "pedro" y "lucas"
    Y el grupo tiene un gasto equitativo para pagar de "149"
    Cuando quiero pagar el gasto del grupo
    Entonces veo que pago "29.8"
