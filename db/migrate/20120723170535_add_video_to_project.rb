class AddVideoToProject < ActiveRecord::Migration
  def change
    add_column :projects, :video_url, :text
  end
end
