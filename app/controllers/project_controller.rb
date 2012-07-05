class ProjectController < ApplicationController

  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
  end

  def edit
    @project = Project.find(params[:id])
  end

end
