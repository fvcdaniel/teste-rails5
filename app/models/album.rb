class Album < ActiveRecord::Base
  has_many :musicas
  belongs_to :user
  validates_presence_of :nome, :message => 'Nome nao pode ficar em branco'
  
  def name
    return self.nome
  end
end
