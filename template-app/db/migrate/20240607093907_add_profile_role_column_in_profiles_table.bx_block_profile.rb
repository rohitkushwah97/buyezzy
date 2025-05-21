# This migration comes from bx_block_profile (originally 20210405070314)
# Protected File
# frozen_string_literal: true

class AddProfileRoleColumnInProfilesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :profile_role, :integer
  end
end
