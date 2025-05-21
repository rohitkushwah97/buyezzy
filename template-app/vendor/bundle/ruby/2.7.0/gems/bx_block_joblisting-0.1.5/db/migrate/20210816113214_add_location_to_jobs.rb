class AddLocationToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :preffered_location, :string, array: true, default: []
  end
end
