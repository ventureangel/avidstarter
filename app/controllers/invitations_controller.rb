class InvitationsController < ApplicationController
  def destroy 
    @invitation = Invitation.find(params[:id])
    if current_account.projects.includes(Project.find(@invitation.project_id))
      if @invitation.destroy
        flash[:notice] = "Membership successfully removed"
        redirect_to :back
      else
        flash[:warning] = "Membership not removed"
        redirect_to :back
      end
    else 
       flash[:warning] = "You cannot remove memberships from this project"
       redirect_to :root
    end
  end
end
