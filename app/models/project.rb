class Project < ActiveRecord::Base
  attr_accessible :business_name, :industry, :city, :state, :business_concept

  has_many :memberships
  has_many :confirmed_memberships, :class_name => 'Membership', :conditions => {:pending => false}
  has_many :members, :through => :confirmed_memberships, :source => :account
  

end
