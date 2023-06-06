Sequel.migration do
  up do
    add_column :usuarios, :saldo, Float
  end

  down do
    drop_column :usuarios, :saldo
  end
end
