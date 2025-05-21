class AddCompanyPageIdColumnToJobsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :company_page_id, :integer
  end
end
