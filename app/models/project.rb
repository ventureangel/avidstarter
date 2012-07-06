class Project < ActiveRecord::Base
  attr_accessible :business_name, :industry, :city, :state, :business_concept

  has_many :memberships, :dependent => :destroy
  has_many :confirmed_memberships, :class_name => 'Membership', :conditions => {:pending => false}
  has_many :members, :through => :confirmed_memberships, :source => :account

  accepts_nested_attributes_for :memberships 
  
  def invite_member(params)
    account = check_if_user(params[:email])
    unless account
      membership = Membership.new(:account_id => Account.new(:email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name], :invited_by_id => current_account.id), :project_id => self.id)
    else
      membership = Membership.new(:account => account, :project => self)
    end
    unless membership.save
      badecode
    end
  end

  # Checks database for a user based on e-mail. If present, return that user. If not, returns false 
  def check_if_user(email)
    account = Account.where(:email => email)
    if account.empty?
      return false
    else
      return account.first
    end
  end

end
