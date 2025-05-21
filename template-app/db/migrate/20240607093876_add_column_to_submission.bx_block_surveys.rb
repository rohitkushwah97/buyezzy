# This migration comes from bx_block_surveys (originally 20230612123946)
class AddColumnToSubmission < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_surveys_submissions, :answer_type, :string
    add_column :bx_block_surveys_submissions, :rating, :integer
    add_column :bx_block_surveys_submissions, :option_ids, :string, array: true
  end
end
