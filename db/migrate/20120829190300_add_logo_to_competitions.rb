class AddLogoToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :logo, :string
  end
end
