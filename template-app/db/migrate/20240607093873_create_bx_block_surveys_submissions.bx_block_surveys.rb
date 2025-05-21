# This migration comes from bx_block_surveys (originally 20230406115801)
class CreateBxBlockSurveysSubmissions < ActiveRecord::Migration[6.0]
  def up
    unless table_exists?(:bx_block_surveys_submissions)
      create_table :bx_block_surveys_submissions do |t|
        t.text :answer
        t.bigint :account_id   
        t.bigint :question_id
        t.timestamps
      end
      add_index :bx_block_surveys_submissions, :account_id
      add_index :bx_block_surveys_submissions, :question_id
    end
  end
    
  def down
    drop_table :bx_block_surveys_submissions, if_exists: true
  end
end
