Sequel.migration do
  up do
    create_join_table(usuario_id: :usuarios, grupo_id: :grupos)
  end

  down do
    drop_table(:usuarios_grupos)
  end
end
