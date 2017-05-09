class CreateContatos < ActiveRecord::Migration
  def change
    create_table :contatos do |t|
      t.string :email
      t.text :texto

      t.timestamps
    end
  end
end
