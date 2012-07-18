class Attachment < ActiveRecord::Base
  attr_accessible :file, :project_id
  belongs_to :project
  validates :file, :project_id, :presence => true
  mount_uploader :file, ImageUploader
  validate :attachment_count

  def attachment_count
    errors.add(:attachment, "Cannot have more than 5 attachments.") if project.attachments.count >= 5
  end
end
