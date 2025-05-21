class CheckDeployment < ActiveRecord::Migration[6.1]
  def change
    remove_index :business_user_generic_answers, name: "generic_question_id"
    remove_index :business_user_generic_answers, name: "index_business_user_generic_answers_on_business_user_id"
    remove_index :business_user_generic_answers, name: "index_business_user_generic_answers_on_internship_id"
  end
end