# This migration comes from bx_block_profile_bio (originally 20210611055613)
# Protected File
# frozen_string_literal: true

# Add account id migration
class AddColumnAccountIdToViewProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :view_profiles, :account_id, :integer
  end
end
