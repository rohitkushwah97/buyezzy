class AddStatusToAppliedJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :applied_jobs, :status, :string, default: 'pending'
  end
end
