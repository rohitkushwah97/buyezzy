class ProjectreportingProjectsRemoveIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :bx_block_projectreporting_projects, column: [:account_id], name: "index_bx_block_projectreporting_projects_on_account_id"
  end
end
