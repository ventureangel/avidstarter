class ProjectsController < ApplicationController
  before_filter :check_if_contributor, :only => [:new, :create, :edit, :update]
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.memberships.build(:account => current_account, :pending => false)
    
    if @project.save
      redirect_to :root
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project successfully updated"
      redirect_to :action => 'edit'
    else
      flash[:warning] = "Project not saved. Try again."
      redirect_to :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.delete
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
