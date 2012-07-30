class MembershipsController < ApplicationController

  def update
    @membership = Membership.find(params[:id]) #if you want to make it so only account can only adjust THEIR memberships, use current_account.memberships.find()
    if @membership.update_attributes(params[:membership])
      flash[:notice] = "Membership successfully updated"
      redirect_to edit_project_path(@membership.project)
    else
      flash[:warning] = "Membership not updated"
      redirect_to :root
    end
  end

  def destroy 
    @membership = Membership.find(params[:id])
    @project = @membership.project
    @my_account = true if @membership.account_id == current_account.id 
    if current_account.projects.includes(@project)
      if @membership.destroy
        flash[:notice] = "Membership successfully removed"
        if @my_account
          redirect_to :root
        else
          redirect_to edit_project_path(@project)
        end 
      else
        flash[:warning] = "Membership not removed"
        redirect_to :root
      end
    else 
       flash[:warning] = "You cannot remove memberships from this project"
       redirect_to :root
    end
  end

end
