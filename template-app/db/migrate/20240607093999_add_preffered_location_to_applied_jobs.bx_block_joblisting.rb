# This migration comes from bx_block_joblisting (originally 20210816134521)
class AddPrefferedLocationToAppliedJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :applied_jobs, :preffered_location, :string
  end
end
