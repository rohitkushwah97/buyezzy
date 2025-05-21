class AddRoleIdToRecommendations < ActiveRecord::Migration[6.1]
  def change
    add_column :bx_block_recommendation_recommendations, :role_id, :bigint
  end
end
