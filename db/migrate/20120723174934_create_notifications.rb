class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.boolean :priority, :default => false
      t.integer :notifier_id
      t.string :notifier_type

      t.timestamps
    end
  end
end
