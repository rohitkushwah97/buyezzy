class UpdateBusinessUserGenericAnswers < ActiveRecord::Migration[6.1]
  def change
    remove_column :business_user_generic_answers, :first_answer, :string
    remove_column :business_user_generic_answers, :first_question, :string
    remove_column :business_user_generic_answers, :second_answer, :string
    remove_column :business_user_generic_answers, :second_question, :string
    remove_column :business_user_generic_answers, :third_answer, :string
    remove_column :business_user_generic_answers, :third_question, :string
    remove_column :business_user_generic_answers, :fourth_question, :string
    remove_column :business_user_generic_answers, :fourth_answer, :string

    add_column :business_user_generic_answers, :answer, :string
    add_reference :business_user_generic_answers, :internship, null: false, foreign_key: { to_table: :bx_block_navmenu_internships }
    add_reference :business_user_generic_answers, :business_user_generic_question, null: false, foreign_key: true, index: { name: 'generic_question_id' }
  end
end
