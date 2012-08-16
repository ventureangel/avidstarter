class AddTimeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :time, :datetime    
  end
end
