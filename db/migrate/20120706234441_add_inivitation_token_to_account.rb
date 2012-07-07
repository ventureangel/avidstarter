class AddInivitationTokenToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :invitation_token, :string
  end
end
