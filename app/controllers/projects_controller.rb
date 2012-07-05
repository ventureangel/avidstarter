class ProjectsController < ApplicationController
  before_filter :check_if_contributor, :only => [:new, :create, :edit]
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    @project.memberships.build(:account_id => current_account.id, :pending => false)
    
    if @project.save
      redirect_to :root
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  private

  def check_if_contributor
    redirect_to :root unless current_account.profile_type == "Contributor"
  end
end
