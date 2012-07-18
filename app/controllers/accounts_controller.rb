class AccountsController < Devise::RegistrationsController
  def edit 
    respond_to do |format|
      format.html
      format.js
    end
  end
end

