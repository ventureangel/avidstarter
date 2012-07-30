class Membership < ActiveRecord::Base
  belongs_to :account
  belongs_to :project
  attr_accessible :account, :pending, :project
  
  
  validates :account_id, :uniqueness => {:scope => :project_id}
  validates :account, :presence => true
  after_create :notify_of_invitation, :unless => Proc.new { self.pending == false }

  private

  def notify_of_invitation
    ProjectMembers.membership_invitation(self).deliver
  end


end
