class NotificationsController < ApplicationController
  def new
    @notification = Notification.new
  end
  def create
    notifier_type = params[:notification][:notifier_type]
    @notification = Notification.new(params[:notification])
   
    if notifier_type == "Project"
      @notifier = current_account.projects.find(params[:notification][:notifier_id].to_i)
    elsif notifier_type == "Account"
      @notifier = current_account
      @notification.priority = true if @notifier.profile_type == "Admin"
    end
 
    @notification.notifier = @notifier
    
    if @notification.save
      flash[:notice] = "#{@notification.type} notification successfully posted"
      redirect_to :back
    else
      flash[:warning] = "Notification not posted" #@notification.errors.full_messages.to_sentence
      redirect_to :back
    end
 
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You do not have permission to make this notification'
  end

  def destroy
  end
end
