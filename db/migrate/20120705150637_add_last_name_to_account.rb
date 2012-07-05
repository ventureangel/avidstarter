class AddLastNameToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :last_name, :string
    add_column :accounts, :linked_in, :string
    rename_column :accounts, :name, :first_name
  end
end
