class RemoveAccountFromSuggestionFeedback < ActiveRecord::Migration[6.0]
  def change
    remove_reference :suggestion_feedbacks, :account, foreign_key: true
  end
end
