Sequel.migration do
  up do
    create_table(:gastos) do
      primary_key :id
      String :nombre
      Float :monto
      foreign_key :id_grupo, :grupos
      foreign_key :id_creador, :usuarios
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:gastos)
  end
end
