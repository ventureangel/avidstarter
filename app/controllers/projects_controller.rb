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
    step = 'General'
    step = params[:step] if params[:step].present?
    @breadcrumb_name = step
    @project = current_account.projects.find(params[:id], :include => [:attachments, :invitations])
    @project.attachments.build
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot edit this project.'   
  end

  def update
    @project = current_account.projects.find(params[:id])
    @invitations = @project.invitations
    @breadcrumb_name = params[:step]
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project successfully updated"
      redirect_to :back
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
    @project = Project.find(params[:id], :include => [:attachments, :invitations, :comment_threads])
    unless @project.published || current_account.projects.include?(@project)
      return redirect_to root_url, :alert => 'You cannot access this project.'
    end
  end

  # Publishes a project.
  def publish
    @project = current_account.projects.find(params[:id])
    if @project.publish!
      flash[:notice] = 'Your project has been published.'
    else
      flash[:warning] = 'Your project was not published. It must be saved and have a logo to be published.'
    end
    redirect_to root_url
  end

  # Un-Publishes a project.
  def unpublish
    @project = current_account.projects.find(params[:id])
    if @project.unpublish!
      flash[:notice] = 'Your project has been un-published.'
    else
      flash[:warning] = 'Your project was not un-published.'
    end
    redirect_to root_url
  end
  
  def index
    if current_account.profile_type == "Admin"
      @projects = Project.all
    else
      flash[:warning] = 'You cannot access this page.'
      redirect_to root_url
    end
  end
  
  private
  
  def check_if_contributor
    redirect_to :root unless current_account.profile_type == "Contributor"
  end
end
