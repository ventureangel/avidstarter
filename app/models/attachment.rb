class Attachment < ActiveRecord::Base
  attr_accessible :file, :project_id
  belongs_to :project
  validates :file, :project_id, :presence => true
  mount_uploader :file, ImageUploader
end
