class Membership < ActiveRecord::Base
  belongs_to :account
  belongs_to :project
  attr_accessible :account, :pending, :project
  
  validates :account_id, :uniqueness => {:scope => :project_id}
# Invites member to project through project edit page
  def invite_member(params)
    
  end

  # Checks database for an account based on e-mail. If present, return that account. If not, returns a new account 
  def self.check_if_user(params)
    @account = Account.find_by_email(params[:email])
    unless @account
      badecode
      invite_member(params)#create the account
    else
      return @account
    end
  end


end
