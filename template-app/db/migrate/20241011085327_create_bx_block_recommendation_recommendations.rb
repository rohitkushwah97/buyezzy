class CreateBxBlockRecommendationRecommendations < ActiveRecord::Migration[6.1]
  def change
    create_table :bx_block_recommendation_recommendations do |t|
      t.bigint :internship_id, null: false
      t.bigint :intern_user_id, null: false
      t.string :match_type

      t.timestamps
    end
  end
end
