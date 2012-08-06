class NotificationsController < ApplicationController

  def index
    if params[:project_id]
      @notifier = current_account.projects.find(params[:project_id])
      @project = @notifier
      @notifications =  @notifier.notifications    
    elsif params[:account_id]
      @notifier = Account.find(params[:account_id]) 
      @project = @notifier 
      @notifications =  @notifier.notifications       
    elsif
      @notifications = Notification.all
      @project = @notifier     
    end  
    
    @breadcrumb_name = "View Notifications"  
  end

  def new
    if params[:project_id]
      @notifier = current_account.projects.find(params[:project_id])
    elsif params[:account_id]
      if current_account.id != params[:account_id].to_i
        flash[:warning] = "You can only post notifications for your own account"
        redirect_to :root
      else
        @notifier = current_account
      end
    end
    @notification = Notification.new
  end
  
  def create
    notifier_type = params[:notification][:notifier_type]
    @notification = Notification.new(params[:notification])
   
    if notifier_type == "Project"
      @notifier = current_account.projects.find(params[:notification][:notifier_id].to_i)
    elsif notifier_type == "Account"
      @notifier = current_account
    end
 
    @notification.notifier = @notifier
    
    if @notification.save
      flash[:notice] = "#{@notification.notification_type} notification successfully posted"
      redirect_to notification_path(@notification)
    else
      flash[:warning] = "Notification not posted" #@notification.errors.full_messages.to_sentence
      render :new
    end
 
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_url, :alert => 'You do not have permission to make this notification'
  end

  def edit
    @notification = Notification.find(params[:id])
    unless have_permission?(@notification)
      flash[:warning] = 'You do not have permission to edit this notification'
      redirect_to :root
    end
    
    rescue ActiveRecord::RecordNotFound
      return redirect_to :root, :alert => 'Notification does not exist'
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def destroy
  end

  private

    def have_permission?(notification)
      if notifaction.notifier_type == 'Project'
        return current_account.projects.include?(notification.notifier)
      elsif notification.notifier_type == 'Account'
        return current_account = notification.notifier
      else
        return false
      end
    end
end
