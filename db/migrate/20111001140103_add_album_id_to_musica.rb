class AddAlbumIdToMusica < ActiveRecord::Migration
  def change
    add_column :musicas, :album_id, :integer
  end
end
