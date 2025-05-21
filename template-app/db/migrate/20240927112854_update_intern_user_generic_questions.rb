class UpdateInternUserGenericQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :intern_user_generic_questions, :first_question, :string
    remove_column :intern_user_generic_questions, :second_question, :string
    remove_column :intern_user_generic_questions, :third_question, :string

    add_column :intern_user_generic_questions, :question, :string
  end
end
