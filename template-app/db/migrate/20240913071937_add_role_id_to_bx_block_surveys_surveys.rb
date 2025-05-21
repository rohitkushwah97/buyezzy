class AddRoleIdToBxBlockSurveysSurveys < ActiveRecord::Migration[6.1]
  def up
    add_column :bx_block_surveys_surveys, :role_id, :integer
  end

  def down
    remove_column :bx_block_surveys_surveys, :role_id, :integer
  end
end
