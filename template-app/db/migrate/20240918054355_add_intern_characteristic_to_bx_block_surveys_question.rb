class AddInternCharacteristicToBxBlockSurveysQuestion < ActiveRecord::Migration[6.1]
  def up
    add_column :bx_block_surveys_questions, :intern_characteristic_id, :integer
    add_column :bx_block_surveys_questions, :default_weight, :string
    add_column :bx_block_surveys_questions, :business_question, :text
    add_column :bx_block_surveys_questions, :intern_question, :text
  end

  def down
    remove_column :bx_block_surveys_questions, :intern_characteristic_id, :integer
    remove_column :bx_block_surveys_questions, :default_weight, :string
    remove_column :bx_block_surveys_questions, :business_question, :text
    remove_column :bx_block_surveys_questions, :intern_question, :text
  end
end
