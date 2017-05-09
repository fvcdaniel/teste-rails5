class CreateFormatos < ActiveRecord::Migration
  def change
    create_table :formatos do |t|
      t.string :nome
      t.string :tipo

      t.timestamps
    end
  end
end
