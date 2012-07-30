class Invitation < ActiveRecord::Base
  attr_accessible :invitation_token, :project_id, :recipient_email, :sent_at, :recipient_name
  belongs_to :project
  validates :recipient_email, :project_id, :recipient_name, :presence => true
  validates :recipient_email, :uniqueness => {:scope => :project_id}
  before_create :generate_token
  after_create :new_user_membership_invitation

  def label
    "#{recipient_name} (#{recipient_email})"
  end

  private
    def generate_token
      self.invitation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end

    def new_user_membership_invitation
      ProjectMembers.new_user_membership_invitation(self).deliver
    end
end
