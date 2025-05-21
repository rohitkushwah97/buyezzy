class AddScoreToRecommendations < ActiveRecord::Migration[6.1]
  def up
    add_column :bx_block_recommendation_recommendations, :score,:float
  end

  def down
    add_column :bx_block_recommendation_recommendations, :score,:float
  end
end
