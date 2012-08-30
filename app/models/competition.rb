class Competition < ActiveRecord::Base

  attr_accessible :competition_name, :location, :city, :state, :date, :time, :accepting_business_plans, :prize, :competition_details, :requirements, :competition_logo, :judges_attributes, :additional_info
  validates :competition_name, :location, :city, :state, :date, :time, :competition_details, :requirements, :presence => true
  
  has_many :submissions, :dependent => :destroy
  has_many :projects, :through => :submissions
  has_many :judges, :dependent => :destroy

  mount_uploader :competition_logo, ImageUploader
  mount_uploader :additional_info, BusinessPlanUploader

  accepts_nested_attributes_for :judges, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  
end
