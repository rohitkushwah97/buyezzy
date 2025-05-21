class AddVersionIdToSubmissions < ActiveRecord::Migration[6.1]
  def up
    add_column :bx_block_surveys_submissions, :version_id, :bigint
    add_column :bx_block_surveys_submissions, :option_id, :bigint
  end

  def down
    remove_column :bx_block_surveys_submissions, :version_id, :bigint
    remove_column :bx_block_surveys_submissions, :option_id, :bigint
  end
end
