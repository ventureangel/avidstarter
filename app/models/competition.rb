class Competition < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :competition_name, :location, :city, :state, :date, :time, :accepting_business_plans, :prize, :competition_details, :requirements
  validates :competition_name, :location, :city, :state, :date, :time, :competition_details, :requirements, :presence => true
  
  mount_uploader :logo, ImageUploader
  mount_uploader :business_plan, BusinessPlanUploader
  
end
