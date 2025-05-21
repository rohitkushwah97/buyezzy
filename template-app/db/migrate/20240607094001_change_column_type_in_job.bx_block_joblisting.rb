# This migration comes from bx_block_joblisting (originally 20220103055115)
class ChangeColumnTypeInJob < ActiveRecord::Migration[6.0]
  def up
    remove_column :jobs, :industries, :string
    add_column :jobs, :industry_id, :integer
  end

  def down
    add_column :jobs, :industries, :string
    remove_column :jobs, :industry_id, :integer
  end
end
