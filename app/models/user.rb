class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :musicas
  has_many :pedidos
  has_many :albums
  scope :subscribed, where("unsubscribed_at is null")
  
  after_create :addCommonRole
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable, :encryptable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def addCommonRole
    role = Role.where(:name=>"CommonUser")
    unless self.roles.include? role
      self.roles << role
    end
  end
  
  def addRole(role_name)
    role = Role.where(:name=>role_name).first
    unless self.roles.include? role
      self.roles << role
    end
  end
  
  def removeRole(role_name)
    role = Role.where(:name=>role_name).first
    puts role.id
    puts self.id
    if self.roles.include? role
      return roles.delete role
    end
    return false
  end
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def musica?(musica)
    return !!self.musicas.find_by_name(musica.to_s.camelize)
  end
  
end
