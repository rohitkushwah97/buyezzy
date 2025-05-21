class CreateSuggestionFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestion_feedbacks do |t|
      t.string :detail_type
      t.string :detail
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :account, null: false, foreign_key: true


      t.timestamps
    end
  end
end
