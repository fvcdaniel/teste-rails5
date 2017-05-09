class CreatePedidos < ActiveRecord::Migration
  def change
    create_table :pedidos do |t|
      t.belongs_to :user
      t.belongs_to :musica
      t.string :status
      t.decimal :preco
      t.string :descricao
      t.datetime :dt_pedido

      t.timestamps
    end
    add_index :pedidos, :user_id
    add_index :pedidos, :musica_id
  end
end
