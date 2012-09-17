module ApplicationHelper
  def users_projects
    @user_projects = current_account.projects 
  end
  
  def resource_name
   :account
  end
  
  def upcoming_comps
    Competition.where(:date => ((Time.now.utc)..(Time.now + 1.week)))
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

  def link_to_add_fields(name, f, association, c)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => c)
  end

  def link_to_remove_fields(name, f, c)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => c)
  end
  
  def business_plan_list 
    #this creates an array of the user's completed projects with the project's name and its id.
    #note: idea is you can submit a completed business plan, regardless of whether it's published
    #if we want only published business plans we should use the code below:
    current_account.projects.where(:published => true).map {|project| [project.business_name, project.id]}  
    # current_account.projects.where("logo IS NOT NULL").map {|project| [project.business_name, project.id]}
  end
end
