Sequel.migration do
  up do
    add_column :gastos, :tipo, String
  end

  down do
    drop_column :gastos, :tipo
  end
end
