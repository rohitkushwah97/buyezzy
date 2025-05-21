class AddOptionValuesSubmission < ActiveRecord::Migration[6.1]
 def up
    add_column :bx_block_surveys_submissions, :option_value, :float
    remove_column :bx_block_surveys_questions, :default_weight, :string
    add_column :bx_block_surveys_questions, :default_weight, :integer
  end

  def down
    remove_column :bx_block_surveys_submissions, :option_value, :float
    add_column :bx_block_surveys_questions, :default_weight, :string
    remove_column :bx_block_surveys_questions, :default_weight, :integer
  end
end
