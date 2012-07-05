class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :business_name
      t.string :industry
      t.string :city
      t.string :state
      t.text :business_concept
      t.timestamps
    end
  end
end
