class AddAddressInJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :addresses, :string, array: true, default: []
  end
end
