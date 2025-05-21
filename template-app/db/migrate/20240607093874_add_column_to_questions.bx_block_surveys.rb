# This migration comes from bx_block_surveys (originally 20230609073403)
class AddColumnToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_surveys_questions, :question_type, :string
    add_column :bx_block_surveys_questions, :rating, :integer
  end
end
