class CreateDefaultRoles < ActiveRecord::Migration
  def up
    role = Role.new
    role.name = "SuperAdmin"
    role.save
    role = Role.new
    role.name = "ArtistUser"
    role.save
    role = Role.new
    role.name = "CommonUser"
    role.save
  end

  def down
    Role.delete_all
  end
end
