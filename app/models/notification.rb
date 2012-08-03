class Notification < ActiveRecord::Base
  attr_accessible :date, :description, :priority, :title, :notifier_id, :notifier_type, :notification_type
  validates :title, :description, :notifier_id, :notifier_type, :notification_type, :presence => true
  validates :date, :presence => true, :if => :event?
  validate :should_have_date?

  before_create :set_priority, :if => :admin?

  belongs_to :notifier, :polymorphic => true


  def admin?
    if notifier_type == 'Account'
      return self.notifier.profile_type == 'Admin'
    else
      return false
    end
  end

  def set_priority
    self.priority = true
  end

  def should_have_date?
   unless notification_type == 'Event'
     if date.present?
       errors.add(:notification, "can't have a date unless it is an event")
     end
   end
  end

  def event?
    notification_type == 'Event'
  end

end
