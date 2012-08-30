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
    @all_projects = Project.where(:published => true)
  end
  
  def active_member?(project)
    current_account.projects.include?(project) if account_signed_in?
  end
  
  def linkedinurl(linkedin)
    "http://www.linkedin.com/in/#{linkedin}"
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
end
