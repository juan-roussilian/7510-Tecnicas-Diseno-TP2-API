Sequel.migration do
  up do
    add_column :usuarios, :telegram_id, String
  end

  down do
    drop_column :usuarios, :telegram_id
  end
end
