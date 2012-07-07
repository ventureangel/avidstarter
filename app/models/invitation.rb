class Invitation < ActiveRecord::Base
  attr_accessible :invitation_token, :project_id, :recipient_email, :sent_at, :recipient_name
  belongs_to :project
  validates_presence_of :recipient_email
  before_create :generate_token

  private
    def generate_token
      self.invitation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end

end
