class AddDeletedAtToMusica < ActiveRecord::Migration
  def change
    add_column :musicas, :deleted_at, :datetime
  end
end
