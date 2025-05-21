class CreateBxBlockSurveysQuestions < ActiveRecord::Migration[6.0]
  def up
    unless table_exists?(:bx_block_surveys_questions)
      create_table :bx_block_surveys_questions do |t|
        t.string :question_title
        t.bigint :survey_id
        t.integer :sequence
        t.timestamps
      end
      add_index :bx_block_surveys_questions, :survey_id
    end
  end
    
  def down
    drop_table :bx_block_surveys_questions, if_exists: true
  end
end
