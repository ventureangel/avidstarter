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

end
