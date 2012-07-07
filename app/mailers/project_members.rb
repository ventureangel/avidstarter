class ProjectMembers < ActionMailer::Base
  default from: "from@example.com"

  def membership_invitation(membership)
    @project = membership.project
    @account    = membership.account

    mail( :subject => %(Invitation to join project #{@project.business_name}),
          :from    => %("avidstarter" <no-reply@ventureangel.com>),
          :to      => @account.email ) do |format|
        format.text
        format.html
      end
  end

  def new_user_membership_invitation(invitation, sign_up_url)
    @invitation = invitation
    @project = @invitation.project
    @sign_up_url = sign_up_url
    mail( :subject => %(Invitation to join project #{@project.business_name}),
          :from    => %("avidstarter" <no-reply@ventureangel.com>),
          :to      => invitation.recipient_email ) do |format|
        format.text
        format.html
      end
  end

end
