class Musica < ActiveRecord::Base
  attr_accessible :id, :nome, :artista, :ano, :arquivo, :album
  belongs_to :formato
  belongs_to :album
  has_and_belongs_to_many :users
  mount_uploader :arquivo, MusicaUploader
  scope :active,where("musicas.deleted_at is null")
  scope :deleted,where("musicas.deleted_at is not null")
  
  def self.search(search)
    if search
      where('nome LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def destroy
    update_attributes!(:deleted_at=>DateTime.now)
  end 

end
