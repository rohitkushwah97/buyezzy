# This migration comes from bx_block_joblisting (originally 20220527061546)
class AddAddressInJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :addresses, :string, array: true, default: []
  end
end
