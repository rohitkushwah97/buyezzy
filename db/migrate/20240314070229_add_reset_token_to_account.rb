class AddResetTokenToAccount < ActiveRecord::Migration[6.0]
  def change
  	add_column :accounts, :reset_token, :string
  	add_column :accounts, :reset_token_used_at, :datetime
  end
end
