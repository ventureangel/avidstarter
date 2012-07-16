class AddBusinessPlanToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :business_plan, :string
  end
end
