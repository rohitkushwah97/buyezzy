class AddInternshipOnReports < ActiveRecord::Migration[6.1]
  def up
    add_column :reports, :internship_id, :bigint
  end

  def down
    remove_column :reports, :internship_id, :bigint
  end
end
