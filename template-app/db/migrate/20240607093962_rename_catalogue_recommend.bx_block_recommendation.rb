# This migration comes from bx_block_recommendation (originally 20230414103235)
class RenameCatalogueRecommend < ActiveRecord::Migration[6.0]
  def self.up
    if ActiveRecord::Base.connection.data_source_exists?'bx_block_recommendation_catalogue_recommands'
      rename_table :bx_block_recommendation_catalogue_recommands, :bx_block_recommendation_catalogue_recommends
    end
  end

  def self.down
    rename_table :bx_block_recommendation_catalogue_recommends, :bx_block_recommendation_catalogue_recommands
  end
end
