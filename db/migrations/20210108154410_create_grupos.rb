Sequel.migration do
  up do
    create_table(:grupos) do
      primary_key :id
      String :nombre
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:grupos)
  end
end
