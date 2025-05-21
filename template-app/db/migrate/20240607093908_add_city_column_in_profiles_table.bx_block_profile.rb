# This migration comes from bx_block_profile (originally 20210723071617)
# Protected File
# frozen_string_literal: true

class AddCityColumnInProfilesTable < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :city, :string
  end
end
