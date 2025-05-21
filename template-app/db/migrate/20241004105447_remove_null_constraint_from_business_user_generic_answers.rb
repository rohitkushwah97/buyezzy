class RemoveNullConstraintFromBusinessUserGenericAnswers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :business_user_generic_answers, :business_user_id, true
    change_column_null :business_user_generic_answers, :internship_id, true
    change_column_null :business_user_generic_answers, :business_user_generic_question_id, true
  end
end
