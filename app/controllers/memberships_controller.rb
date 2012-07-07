class MembershipsController < ApplicationController
  def create
    @membership = Membership.new(:project => Project.find(params[:membership][:project]))
    @account = Membership.check_if_user(params[:membership])
    unless @account
      invite_member(params[:membership])
      redirect_to :back
    else
      @membership.account = @account
      if @membership.save
        flash[:notice] = "Member invited to project"
        redirect_to :back
      else
        flash[:warning] = "Member not added. Please try again."
        redirect_to :back
      end
    end
  end

  def update
    @membership = Membership.find(params[:id]) #if you want to make it so only account can only adjust THEIR memberships, use current_account.memberships.find()
    if @membership.update_attributes(params[:membership])
      flash[:notice] = "Membership successfully updated"
      redirect_to :back
    else
      flash[:warning] = "Membership not updated"
      redirect_to :back
    end
  end

  def destroy 
    @membership = Membership.find(params[:id])
    if @membership.destroy
      flash[:notice] = "Membership successfully removed"
      redirect_to :back
    else
      flash[:warning] = "Membership not removed"
      redirect_to :back
    end
  end

  private
  # Invites member to project through project edit page
  def invite_member(params)
    @invitation = Invitation.new(:recipient_email => params[:email], :recipient_name => params[:recipient_name], :project_id => params[:project])
    if @invitation.save
      ProjectMembers.new_user_membership_invitation(@invitation, sign_up_url(:invitation_token => @invitation.invitation_token)).deliver
      flash[:notice] = "Invitation sent"
    else
      flash[:warning] = "Invitation not sent"
    end
  end

end
