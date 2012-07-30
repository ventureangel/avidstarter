class Notification < ActiveRecord::Base
  attr_accessible :date, :description, :priority, :title, :notifier_id, :notifier_type, :type
  validates :title, :description, :notifier_id, :notifier_type, :type, :presence => true
  
  belongs_to :notifier, :polymorphic => true

end
