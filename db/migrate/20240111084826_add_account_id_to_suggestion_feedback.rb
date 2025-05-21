class AddAccountIdToSuggestionFeedback < ActiveRecord::Migration[6.0]
  def change
  	add_column :suggestion_feedbacks, :account_id, :bigint
  end
end
