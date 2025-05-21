class AddFieldInAppliedJob < ActiveRecord::Migration[6.0]
  def change
    add_column :applied_jobs, :answer, :string, array: true, default: []

  end
end
