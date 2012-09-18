class CompetitionsController < ApplicationController
  before_filter :check_if_loggedin 
  before_filter :check_if_admin, :only => [:new, :create, :update, :edit, :destroy]
  
  def new
    @competition = Competition.new
    @competition.judges.build
  end
  
  def index
    @competitions = Competition.all
  end
  
  def edit
    @competition = Competition.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot edit this competition.'
  end

  def update
    @competition = Competition.find(params[:id])
    if @competition.update_attributes(params[:competition])
      flash[:notice] = "Project successfully updated"
      redirect_to @competition
    else
      flash[:warning] = "Project not saved. Try again."
      render :action => 'edit'
    end
  end
  
  def show
    @competition = Competition.find(params[:id], :include => :judges)
    
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot access this competition.'
  end
  
  def create
    @competition = Competition.new(params[:competition])
    
    if @competition.save
      flash[:notice] = "Competition successfully created"
      redirect_to @competition
    else
      flash[:warning] = "Competition not created"
      render :action => 'new'
    end
    
  end
  
  def destroy
    @competition = Competition.find(params[:id])
    if @competition.destroy
      flash[:notice] = "Competition successfully deleted"
      redirect_to :action => :index
    else
      flash[:warning] = "Competition not deleted"
      redirect_to :action => :index
    end
  end
  
  private
  
  def check_if_admin
    unless current_account.profile_type == "Admin"
      flash[:warning] = "You must be an Admin to access that page"
      redirect_to :root 
    end
  end
  
  def check_if_loggedin
    redirect_to :root unless account_signed_in?
  end

end
