class AddColumntToAppliedJob < ActiveRecord::Migration[6.0]
  def change
    add_column :applied_jobs, :applicant_status, :string, default: 'new_applicant'
  end
end
