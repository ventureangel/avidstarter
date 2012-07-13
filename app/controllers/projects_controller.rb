class ProjectsController < ApplicationController
  before_filter :check_if_contributor, :only => [:new, :create, :edit, :update]
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.memberships.build(:account => current_account, :pending => false)
    
    if @project.save
      flash[:notice] = "Project successfully created"
      redirect_to :root
    else
      flash[:warning] = "Project not created"
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
    @invitations = @project.invitations
  end

  def update
    @project = Project.find(params[:id])
    @invitations = @project.invitations
    
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project successfully updated"
      render :action => 'edit'
    else
      flash[:warning] = "Project not saved. Try again."
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = "Project successfully deleted"
      redirect_to :root
    else
      flash[:warning] = "Project not deleted"
      redirect_to :root
    end
  end


  private

  def check_if_contributor
    redirect_to :root unless current_account.profile_type == "Contributor"
  end
end
