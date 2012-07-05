class AddProfileTypeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :profile_type, :string
    add_column :accounts, :name, :string
  end
end
