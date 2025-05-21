class CreateInternUserGenericQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :intern_user_generic_questions do |t|
      t.string :first_question
      t.string :second_question
      t.string :third_question
      t.references :business_user, null: false, foreign_key: { to_table: :accounts }
      t.references :internship, null: false, foreign_key: { to_table: :bx_block_navmenu_internships }

      t.timestamps
    end
  end
end
