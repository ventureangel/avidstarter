class AddInvitedToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :invited_by_id, :integer
  end
end
