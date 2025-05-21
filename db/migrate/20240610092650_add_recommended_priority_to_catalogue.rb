class AddRecommendedPriorityToCatalogue < ActiveRecord::Migration[6.0]
  def change
  	add_column :catalogues, :recommended_priority, :integer, default: 0
  	add_index :catalogues, :recommended_priority
  end
end
