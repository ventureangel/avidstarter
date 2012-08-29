class Submission < ActiveRecord::Base
  belongs_to :competition
  belongs_to :project
  attr_accessible :competition, :project

end
