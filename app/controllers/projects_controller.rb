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
    @project = current_account.projects.find(params[:id], :include => [:attachments, :invitations, :comment_threads])
    @project.attachments.build
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot edit this project.'   
  end

  def update
    @project = current_account.projects.find(params[:id])
    @invitations = @project.invitations
    
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project successfully updated"
      redirect_to edit_project_path(@project)
    else
      flash[:warning] = "Project not saved. Try again."
      render :action => 'edit'
    end
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot edit this project.'   
  end

  def destroy
    @project = current_account.projects.find(params[:id])
    if @project.destroy
      flash[:notice] = "Project successfully deleted"
      redirect_to :root
    else
      flash[:warning] = "Project not deleted"
      redirect_to :root
    end
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot delete this project'
  end
  
  def show
    @project = current_account.projects.find(params[:id], :include => [:attachments, :invitations, :comment_threads])
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot access this project.'
  end
  
  private
  
  def check_if_contributor
    redirect_to :root unless current_account.profile_type == "Contributor"
  end
end
