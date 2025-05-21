# Protected File
# frozen_string_literal: true

# Add account id migration
class AddColumnAccountIdToPreferences < ActiveRecord::Migration[6.0]
  def change
    add_column :preferences, :account_id, :integer
  end
end
