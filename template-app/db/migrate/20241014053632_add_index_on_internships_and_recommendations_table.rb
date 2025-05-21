class AddIndexOnInternshipsAndRecommendationsTable < ActiveRecord::Migration[6.1]
  def up
    add_index :bx_block_recommendation_recommendations, :internship_id
    add_index :bx_block_recommendation_recommendations, :intern_user_id
    add_index :bx_block_recommendation_recommendations, :match_type

    #intership_table_indexing
    add_index :bx_block_navmenu_internships, :start_date
    add_index :bx_block_navmenu_internships, :monthly_salary
  end

  def down
    remove_index :bx_block_recommendation_recommendations, :internship_id
    remove_index :bx_block_recommendation_recommendations, :intern_user_id
    remove_index :bx_block_recommendation_recommendations, :match_type

    #intership_table_indexing
    remove_index :bx_block_navmenu_internships, :start_date
    remove_index :bx_block_navmenu_internships, :monthly_salary
  end
end
