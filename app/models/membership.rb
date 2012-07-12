class Membership < ActiveRecord::Base
  belongs_to :account
  belongs_to :project
  attr_accessible :account, :pending, :project
  
  
  validates :account_id, :uniqueness => {:scope => :project_id}
  validates :account, :project, :presence => true
  after_create :notify_of_invitation, :unless => Proc.new { self.pending == false }
  # Checks database for an account based on e-mail. If present, return that account. If not, returns false
  def self.check_if_user(params)
    @account = Account.find_by_email(params[:email])
    unless @account
      return false
    else
      return @account
    end
  end

  private

  def notify_of_invitation
    ProjectMembers.membership_invitation(self).deliver
  end


end
