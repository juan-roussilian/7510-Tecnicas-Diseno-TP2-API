Sequel.migration do
  up do
    add_column :usuarios, :telegram_username, String
  end

  down do
    drop_column :usuarios, :telegram_username
  end
end
