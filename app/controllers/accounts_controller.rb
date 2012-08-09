class AccountsController < Devise::RegistrationsController
  layout "devise"
  
  def edit 
    respond_to do |format|
      format.html
      format.js
    end
  end
end

