class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :competition
      t.references :project 
      t.timestamps
    end
  end
end
