class ChangeTitleDataTypeForNotifications < ActiveRecord::Migration
  def change
    change_table :notifications do |t|
      t.change :title, :text
    end
  end

end
