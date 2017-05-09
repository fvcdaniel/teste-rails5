class CreateMusicas < ActiveRecord::Migration
  def change
    create_table :musicas do |t|
      t.string :nome
      t.string :artista
      t.integer :ano
      t.string :genero
      t.string :tamanho
      t.string :tempo
      t.integer :download
      t.decimal :preco
      t.belongs_to :formato

      t.timestamps
    end
    add_index :musicas, :formato_id
  end
end
