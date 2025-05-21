# Protected File
# frozen_string_literal: true

# Add column to accounts migration
class AddColumnToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :gender, :integer
    add_column :accounts, :date_of_birth, :date
    add_column :accounts, :age, :integer
  end
end
