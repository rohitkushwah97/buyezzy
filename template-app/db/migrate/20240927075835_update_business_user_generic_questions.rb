class UpdateBusinessUserGenericQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :business_user_generic_questions, :first_question, :string
    remove_column :business_user_generic_questions, :second_question, :string
    remove_column :business_user_generic_questions, :third_question, :string
    remove_column :business_user_generic_questions, :fourth_question, :string
    
    add_column :business_user_generic_questions, :question, :string
    add_column :business_user_generic_questions, :title, :string
  end
end
