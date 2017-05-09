class UsersHaveAndBelongToManyMusics < ActiveRecord::Migration
  def up
    create_table :musicas_users, :id => false do |t|
      t.references :musica, :user
      t.datetime :dt_compra
      t.datetime :dt_pagamento
    end
  end

  def down
    drop_table :musicas_users
  end
end
