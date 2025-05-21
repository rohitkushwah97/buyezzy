class DropTableInternshipRecommendations < ActiveRecord::Migration[6.1]
  def change
    drop_table :internship_recommendations
  end
end
