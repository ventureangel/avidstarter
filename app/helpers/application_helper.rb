module ApplicationHelper
  def users_projects
    @projects = current_account.projects 
  end
end
