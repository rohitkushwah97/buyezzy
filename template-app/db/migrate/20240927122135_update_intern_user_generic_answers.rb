class UpdateInternUserGenericAnswers < ActiveRecord::Migration[6.1]
  def change
    remove_column :intern_user_generic_answers, :first_question, :string
    remove_column :intern_user_generic_answers, :second_question, :string
    remove_column :intern_user_generic_answers, :third_question, :string
    remove_column :intern_user_generic_answers, :first_answer, :string
    remove_column :intern_user_generic_answers, :second_answer, :string
    remove_column :intern_user_generic_answers, :third_answer, :string

    add_column :intern_user_generic_answers, :answer, :string
    add_reference :intern_user_generic_answers, :intern_user_generic_question, null: false, foreign_key: { to_table: :intern_user_generic_questions }, index: { name: 'intern_user_generic_answers_on_question_id' }
  end
end
