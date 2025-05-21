# This migration comes from bx_block_surveys (originally 20230609091712)
class CreateBxBlockSurveysOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_surveys_options do |t|
      t.string :name
      t.bigint :question_id
      t.timestamps  
    end
    add_index :bx_block_surveys_options, :question_id
  end
end
