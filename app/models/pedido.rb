class Pedido < ActiveRecord::Base
  belongs_to :user
  belongs_to :musica
  validates_associated :user, :musica
  validates_presence_of :musica, :user
  
  def pago?
    if ["Completo","Aprovado"].include?(self.status)
      return true
    end
    return false
  end
end
