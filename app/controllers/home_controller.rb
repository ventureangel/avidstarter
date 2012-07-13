class HomeController < ApplicationController
  def home
    
    if account_signed_in?
      @projects = current_account.projects 
      @invitations = current_account.pending_memberships
    end
    
  end
end
