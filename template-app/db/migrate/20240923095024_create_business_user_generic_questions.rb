class CreateBusinessUserGenericQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :business_user_generic_questions do |t|
      t.string :first_question
      t.string :second_question
      t.string :third_question
      t.string :fourth_question

      t.timestamps
    end
  end
end
