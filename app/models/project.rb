class Project < ActiveRecord::Base
  attr_accessible :business_name, :industry, :city, :state, :business_concept, :logo, :remote_logo_url, :business_plan, :video_url, :invitee_attributes, :attachments_attributes, :published, :published_at
  
  mount_uploader :logo, ImageUploader
  mount_uploader :business_plan, BusinessPlanUploader
  
  acts_as_commentable
  
  has_many :memberships, :dependent => :destroy
  has_many :confirmed_memberships, :class_name => 'Membership', :conditions => {:pending => false}
  has_many :members, :through => :confirmed_memberships, :source => :account
  has_many :pending_memberships, :class_name => 'Membership', :conditions => {:pending => true}
  
  accepts_nested_attributes_for :memberships, :reject_if => lambda { |a| a[:email].blank? }, :allow_destroy => true

  has_many :invitations, :dependent => :destroy
 
  accepts_nested_attributes_for :invitations, :allow_destroy => true

  has_many :attachments, :dependent => :destroy
  
  accepts_nested_attributes_for :attachments, :reject_if => lambda { |a| a[:file].blank? && a[:remote_file_url].blank? }, :allow_destroy => true

  has_many :notifications, :as => :notifier, :dependent => :destroy
  validates :business_name, :industry, :city, :state, :business_concept, :presence => true
  validate :membership_already_exists?

  def invitee_attributes=(params)
    unless params[:email].blank?
      email = params[:email].downcase
      @account = Account.find_by_email(email)
      if @account == nil
        existing_invitation = self.invitations.find_by_recipient_email(email)
        if existing_invitation == nil
          params[:name] = "New User" if params[:name].blank?
          invitations.build(:recipient_email => email, :recipient_name => params[:name])
        else 
          ProjectMembers.new_user_membership_invitation(existing_invitation).deliver
        end
      else
        unless self.members.include?(@account)
          memberships.build(:account =>@account)
        else
          @membership_exists = true
        end
      end
    end
  end
  
  # Returns all the member email addresses if they have valid accounts

  def complete?
    return id.present? && logo.present?
  end

  def publish!
    return false if !complete?
    self.update_attributes(:published => true, :published_at => Time.now.utc)
  end

  def unpublish!
    self.update_attributes(:published => false)
  end

  def contact_emails
    self.memberships.where(:pending => "false").map {|m| m.account ? m.account.email : nil }.compact.join(",")
  end

  private
    def membership_already_exists?
      errors.add(:member, "already added to project") if @membership_exists
    end

end
