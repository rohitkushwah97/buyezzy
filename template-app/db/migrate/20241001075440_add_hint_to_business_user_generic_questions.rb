class AddHintToBusinessUserGenericQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :business_user_generic_questions, :hint, :string
  end
end