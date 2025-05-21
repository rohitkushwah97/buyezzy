class RenameJobToBxBlockJoblistingJobs < ActiveRecord::Migration[6.0]
  def change
    rename_table :jobs, :bx_block_joblisting_jobs
  end
end
 