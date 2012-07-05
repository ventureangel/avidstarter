class Membership < ActiveRecord::Base
  belongs_to :account
  belongs_to :project
  attr_accessible :account_id, :pending, :project_id
end
