class Judge < ActiveRecord::Base
  attr_accessible :avatar, :competition_id, :name
  belongs_to :competition

  mount_uploader :avatar, ImageUploader

end
