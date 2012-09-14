class Submission < ActiveRecord::Base
  belongs_to :competition
  belongs_to :project
  attr_accessible :competition_id, :project_id

  validates :project_id, :uniqueness => {:scope => :competition_id}
  validates :competition, :presence => true

end
