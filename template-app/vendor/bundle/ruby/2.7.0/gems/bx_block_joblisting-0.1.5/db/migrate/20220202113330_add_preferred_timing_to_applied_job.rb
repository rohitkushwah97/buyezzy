class AddPreferredTimingToAppliedJob < ActiveRecord::Migration[6.0]
  def change
    add_column :applied_jobs, :preferred_timing, :string
  end
end
