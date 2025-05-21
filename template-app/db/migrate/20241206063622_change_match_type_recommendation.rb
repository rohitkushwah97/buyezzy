class ChangeMatchTypeRecommendation < ActiveRecord::Migration[6.1]
 def up
    remove_column :bx_block_recommendation_recommendations, :match_type, :string
    add_column :bx_block_recommendation_recommendations, :match_type, :integer
  end

  def down
    add_column :bx_block_recommendation_recommendations, :match_type, :string
    remove_column :bx_block_recommendation_recommendations, :match_type, :integer
  end
end
