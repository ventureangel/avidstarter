class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, ,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :terms_of_service, :linked_in
  # attr_accessible :title, :body
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_acceptance_of :terms_of_service
  before_create :set_profile_type

  private
    
    def set_profile_type
      if determine_email
        self.profile_type = "Contributor"
      else
        self.profile_type = "Viewer"
      end
    end

   def determine_email
      return email[-7..-1] == "uga.edu"
   end

end
