class Attachment < ActiveRecord::Base
  attr_accessible :file, :project_id, :remote_file_url
  belongs_to :project
  validates :file, :project_id, :presence => true
  mount_uploader :file, ImageUploader
  validate :attachment_count

  def attachment_count
    errors.add(:project, "cannot have more than 5 attachments.") if self.project.attachments.count >= 5
  end
end
