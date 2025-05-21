# This migration comes from bx_block_joblisting (originally 20221010110935)
class AddColumnInJob < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :sub_emplotyment_type, :string
  end
end
