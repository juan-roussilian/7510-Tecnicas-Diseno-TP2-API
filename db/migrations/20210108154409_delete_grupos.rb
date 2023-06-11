Sequel.migration do
  up do
    drop_table(:grupos)
  end

  down do
    create_table(:grupos) do
      String :nombre
      primary_key [:nombre]
    end
  end
end
