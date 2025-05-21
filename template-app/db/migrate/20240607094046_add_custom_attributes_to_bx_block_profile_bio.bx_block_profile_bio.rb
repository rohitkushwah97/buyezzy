# This migration comes from bx_block_profile_bio (originally 20220817121248)
# Protected File
# frozen_string_literal: true

# Add custom attributes migration
class AddCustomAttributesToBxBlockProfileBio < ActiveRecord::Migration[6.0]
  def change
    add_column :profile_bios, :custom_attributes, :jsonb
  end
end
