Sequel.migration do
  up do
    create_table(:grupos) do
      String :nombre
      primary_key [:nombre]
    end
  end

  down do
    drop_table(:grupos)
  end
end
