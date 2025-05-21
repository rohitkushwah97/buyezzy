# frozen_string_literal: true

class AddIndexIsBlacklistedColumnToAccount < ActiveRecord::Migration[6.0]
  def change
    add_index :accounts, :is_blacklisted
  end
end
