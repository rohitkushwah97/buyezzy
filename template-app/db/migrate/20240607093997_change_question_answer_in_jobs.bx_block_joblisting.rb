# This migration comes from bx_block_joblisting (originally 20210811114713)
class ChangeQuestionAnswerInJobs < ActiveRecord::Migration[6.0]
  def change
    remove_column :jobs, :question_answer_id, :integer
    add_column :jobs, :question_answer_id, :string, array: true, default: []
  end
end
