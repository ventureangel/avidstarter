class Invitation < ActiveRecord::Base
  attr_accessible :invitation_token, :project_id, :recipient_email, :sent_at, :recipient_name
  belongs_to :project
  validates :recipient_email, :project_id, :recipient_name, :presence => true
  before_create :generate_token

  def label
    "#{recipient_name} (#{recipient_email})"
  end

  private
    def generate_token
      self.invitation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end

end
