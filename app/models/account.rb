class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, ,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
 
  mount_uploader :avatar, ImageUploader
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :terms_of_service, :linked_in, :invitation_token, :avatar, :remote_avatar_url 

  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_acceptance_of :terms_of_service
  before_create :set_profile_type
  after_create :create_memberships_from_invitations, :if => :invited?

  has_many :memberships, :dependent => :destroy
  has_many :confirmed_memberships, :class_name => 'Membership', :conditions => {:pending => false}
  has_many :pending_memberships, :class_name => 'Membership', :conditions => {:pending => true}
  has_many :projects, :through => :confirmed_memberships
  has_many :project_invitations, :through => :pending_memberships, :source => :project


  def invited?
    return self.invitation_token?
  end

  def name
    "#{first_name} #{last_name}"
  end

  def label
    "#{name} (#{email})"
  end
  
  private
    
    # Sets your account type before create based on your e-mail using determine_email
    def set_profile_type
      if determine_email
        self.profile_type = "Contributor"
      else
        self.profile_type = "Viewer"
      end
    end
    
    #checks if you have a school email
    def determine_email
      return email[-7..-1] == "uga.edu"  # this should be a constant
    end
    
    #checks for invitation token on creation

 
    #creates memberships based on accounts invitation token
    def create_memberships_from_invitations
      @invitation = Invitation.find_by_invitation_token(self.invitation_token)
      unless @invitation.nil?
        @project = Project.find(@invitation.project_id)
        @membership = Membership.new(:project => @project, :account => self)
        @membership.save
        @invitation.destroy
      end
      @other_invites = Invitation.where(:recipient_email => self.email)
      unless @other_invites.blank?
        @other_invites.each do |invite|
          @membership = Membership.new(:project => Project.find(invite.project_id), :account => self)
          @membership.save
          invite.destroy
        end
      end     
    end









end
