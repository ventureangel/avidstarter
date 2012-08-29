class Competition < ActiveRecord::Base

  attr_accessible :competition_name, :location, :city, :state, :date, :time, :accepting_business_plans, :prize, :competition_details, :requirements, :logo
  validates :competition_name, :location, :city, :state, :date, :time, :competition_details, :requirements, :presence => true
  
  has_many :submissions, :dependent => :destroy
  has_many :projects, :through => :submissions
  has_many :judges

  mount_uploader :competition_logo, ImageUploader

  
end
