# language: es
Característica: Como Usuario quiero que la app me permita pagar un gasto a la gorra de mi grupo

  @local
  Escenario: 12.1 Usuario en un grupo de 4 personas paga un gasto equitativo
    Dado que soy un usuario registrado y poseo saldo 500
    Y estoy en un grupo con "juan", "pedro" y "lucas"
    Y el grupo tiene un gasto a la gorra para pagar de "100"
    Cuando quiero pagar el gasto del grupo
    Entonces veo que pago "100"
    Y mi saldo pasa a ser 400

  @local
  Escenario: 12.2 Usuario en un grupo de 2 personas paga un gasto equitativo
    Dado que soy un usuario registrado y poseo saldo 75
    Y estoy en un grupo con "juan"
    Y el grupo tiene un gasto a la gorra para pagar de "150"
    Cuando quiero pagar el gasto del grupo
    Entonces veo que pago "75"
    Y mi saldo pasa a ser 0

  @local
  Escenario: 12.3 Un miembro del grupo paga una parte el resto debe pagar lo que falta
    Dado que soy un usuario registrado y poseo saldo 75
    Y estoy en un grupo con "juan"
    Y el grupo tiene un gasto a la gorra para pagar de "40"
    Cuando "juan" paga 100 del gasto del grupo
    Entonces el resto del grupo debe 0
