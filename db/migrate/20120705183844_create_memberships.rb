class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :account
      t.references :project 
      t.boolean :pending, :default => true

      t.timestamps
    end
  end
end
