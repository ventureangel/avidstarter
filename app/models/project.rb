class Project < ActiveRecord::Base
  attr_accessible :business_name, :industry, :city, :state, :business_concept

  has_many :memberships, :dependent => :destroy
  has_many :confirmed_memberships, :class_name => 'Membership', :conditions => {:pending => false}
  has_many :members, :through => :confirmed_memberships, :source => :account
  has_many :pending_memberships, :class_name => 'Membership', :conditions => {:pending => true}
  
  
end
