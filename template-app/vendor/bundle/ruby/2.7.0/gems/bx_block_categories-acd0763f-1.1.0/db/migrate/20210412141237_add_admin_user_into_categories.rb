# Protected File
# frozen_string_literal: true

class AddAdminUserIntoCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :admin_user_id, :integer
  end
end
