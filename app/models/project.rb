class Project < ActiveRecord::Base
  attr_accessible :business_name, :industry, :city, :state, :business_concept, :logo, :remote_logo_url, :business_plan
  
  mount_uploader :logo, LogoUploader
  mount_uploader :business_plan, BusinessPlanUploader
  
  has_many :memberships, :dependent => :destroy
  has_many :confirmed_memberships, :class_name => 'Membership', :conditions => {:pending => false}
  has_many :members, :through => :confirmed_memberships, :source => :account
  has_many :pending_memberships, :class_name => 'Membership', :conditions => {:pending => true}
  has_many :invitations
  
  validates :business_name, :industry, :city, :state, :business_concept, :presence => true
  
end
