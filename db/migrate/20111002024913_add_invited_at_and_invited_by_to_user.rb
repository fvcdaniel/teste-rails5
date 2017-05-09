class AddInvitedAtAndInvitedByToUser < ActiveRecord::Migration
  def change
    add_column :users, :invited_at, :datetime
    add_column :users, :invited_by, :integer
  end
end
