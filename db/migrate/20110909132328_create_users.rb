class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nm_usuario
      t.string :ds_email
      t.string :ds_senha

      t.timestamps
    end
  end
end
