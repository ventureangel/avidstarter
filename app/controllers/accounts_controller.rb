class AccountsController < Devise::RegistrationsController

  layout "devise"
  
  def index
    if account_signed_in?
    else
      return redirect_to :sign_in, :alert => 'You must sign-in view all users.' 
    end
  end
  
  def edit 
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    if account_signed_in?
      @account = Account.find(params[:id])
      
    else
      return redirect_to :sign_in, :alert => 'You must sign-in view users.' 
    end
  end
   
end

