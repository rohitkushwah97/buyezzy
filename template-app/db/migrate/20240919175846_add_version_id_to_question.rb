class AddVersionIdToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :bx_block_surveys_questions, :version_id, :integer
  end
end
