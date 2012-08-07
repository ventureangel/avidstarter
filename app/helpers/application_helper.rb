module ApplicationHelper
  def users_projects
    @user_projects = current_account.projects 
  end
  
  def resource_name
   :account
  end

  def resource
   @resource ||= Account.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:account]
  end
  
  def all_projects
    @all_projects = Project.all 
  end
  
  def active_member?(project)
    current_account.projects.include?(project) if account_signed_in?
  end
end
