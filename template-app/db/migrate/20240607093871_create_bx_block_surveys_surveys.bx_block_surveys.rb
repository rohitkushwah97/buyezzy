# This migration comes from bx_block_surveys (originally 20230405071634)
class CreateBxBlockSurveysSurveys < ActiveRecord::Migration[6.0]
  def up
    unless table_exists?(:bx_block_surveys_surveys)
      create_table :bx_block_surveys_surveys do |t|
        t.string :name
        t.text :description
        t.boolean :is_activated, default: false
        t.timestamps
      end
    end
  end
    
  def down
    drop_table :bx_block_surveys_surveys, if_exists: true
  end
end
