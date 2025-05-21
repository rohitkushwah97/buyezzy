# This migration comes from bx_block_joblisting (originally 20220202113330)
class AddPreferredTimingToAppliedJob < ActiveRecord::Migration[6.0]
  def change
    add_column :applied_jobs, :preferred_timing, :string
  end
end
