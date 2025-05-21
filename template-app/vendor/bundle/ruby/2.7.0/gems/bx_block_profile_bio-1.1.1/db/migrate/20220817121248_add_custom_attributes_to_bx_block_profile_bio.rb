# Protected File
# frozen_string_literal: true

# Add custom attributes migration
class AddCustomAttributesToBxBlockProfileBio < ActiveRecord::Migration[6.0]
  def change
    add_column :profile_bios, :custom_attributes, :jsonb
  end
end
