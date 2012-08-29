class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges do |t|
      t.string :name
      t.integer :competition_id
      t.string :avatar

      t.timestamps
    end
  end
end
