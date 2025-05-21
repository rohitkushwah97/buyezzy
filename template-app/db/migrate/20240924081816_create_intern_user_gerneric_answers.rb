class CreateInternUserGernericAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :intern_user_generic_answers do |t|
      t.string :first_question
      t.string :second_question
      t.string :third_question
      t.string :first_answer
      t.string :second_answer
      t.string :third_answer
      t.references :internship, null: false, foreign_key: { to_table: :bx_block_navmenu_internships }
      t.references :account, null: false, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
