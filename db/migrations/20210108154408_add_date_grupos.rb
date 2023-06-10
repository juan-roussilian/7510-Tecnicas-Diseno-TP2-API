Sequel.migration do
  up do
    add_column :grupos, :created_on, Date
    add_column :grupos, :updated_on, Date
  end

  down do
    drop_column :grupos, :created_on
    drop_column :grupos, :updated_on
  end
end
