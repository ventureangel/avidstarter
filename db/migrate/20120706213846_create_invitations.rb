class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :project_id
      t.string :recipient_email
      t.string :invitation_token
      t.datetime :sent_at
      t.string :recipient_name

      t.timestamps
    end
  end
end
