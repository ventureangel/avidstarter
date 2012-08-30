class AddAdditionalInfoToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :additional_info, :string
  end
end
