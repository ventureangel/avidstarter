class Notification < ActiveRecord::Base
  attr_accessible :date, :description, :priority, :title, :notifier_id, :notifier_type
  #validates :title, :description, :notifier_id, :notifier_type, :presence => true
end
