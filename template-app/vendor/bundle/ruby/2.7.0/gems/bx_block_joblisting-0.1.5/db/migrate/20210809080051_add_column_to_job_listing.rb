class AddColumnToJobListing < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :seniority_level, :string
    add_column :jobs, :job_function, :string
    add_column :jobs, :industries, :string
  end
end
