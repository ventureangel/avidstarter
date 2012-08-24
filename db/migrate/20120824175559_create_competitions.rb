class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :competition_name
      t.datetime :date
      t.datetime :time
      t.string :city
      t.string :state
      t.string :location
      
      t.boolean :accepting_business_plans, :default => false
      t.string :prize
      t.text :competition_details
      t.text :requirements
      
      t.timestamps
    end
  end
end
