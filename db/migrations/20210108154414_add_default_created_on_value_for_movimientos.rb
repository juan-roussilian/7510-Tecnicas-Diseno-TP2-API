Sequel.migration do
  up do
    alter_table(:movimientos) do
      set_column_default :created_on, Sequel::CURRENT_DATE
    end
  end

  down do
    alter_table(:movimientos) do
      set_column_default :created_on, nil
    end
  end
end
