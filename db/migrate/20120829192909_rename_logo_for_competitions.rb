class RenameLogoForCompetitions < ActiveRecord::Migration
  def change
    rename_column :competitions, :logo, :competition_logo
  end
end
