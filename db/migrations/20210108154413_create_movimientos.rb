Sequel.migration do
  up do
    create_table(:movimientos) do
      primary_key :id
      String :tipo
      Float :monto
      foreign_key :id_usuario_principal, :usuarios
      foreign_key :id_usuario_secundario, :usuarios
      foreign_key :id_gasto, :gastos
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:movimientos)
  end
end
