# This migration comes from bx_block_recommendation (originally 20230221141727)
class CreateCatalogueRecommends < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_recommendation_catalogue_recommends do |t|
    	t.string :recommendation_setting
    	t.boolean :value
    end
  end
end
