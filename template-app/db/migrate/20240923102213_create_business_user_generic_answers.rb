class CreateBusinessUserGenericAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :business_user_generic_answers do |t|
      t.string :first_question
      t.string :first_answer
      t.string :second_question
      t.string :second_answer
      t.string :third_question
      t.string :third_answer
      t.string :fourth_question
      t.string :fourth_answer
      t.references :business_user, null: false, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
