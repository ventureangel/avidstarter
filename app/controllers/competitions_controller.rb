class CompetitionsController < ApplicationController
  def new
    @competition = Competition.new
  end
  
  def index
    @competitions = Competition.all
  end
  
  def edit
    @competition = current_account.competitions.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot edit this competition.'
  end
  
  def show
    @competition = Competition.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You cannot access this competition.'
  end
  
  def create
    @competition = Competition.new(params[:competition])
    
    if @competition.save
      flash[:notice] = "Competition successfully created"
      redirect_to :root
    else
      flash[:warning] = "Competition not created"
      render :action => 'new'
    end
    
  end
  
  def destroy
  end
  
end
