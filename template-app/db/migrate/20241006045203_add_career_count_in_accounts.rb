class AddCareerCountInAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :career_count, :integer, default: 0
  end
end
