class AddArquivoToMusicas < ActiveRecord::Migration
  def change
    add_column :musicas, :arquivo, :string
  end
end
