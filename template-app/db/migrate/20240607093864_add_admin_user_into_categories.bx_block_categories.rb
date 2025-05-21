# This migration comes from bx_block_categories (originally 20210412141237)
# Protected File
# frozen_string_literal: true

class AddAdminUserIntoCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :admin_user_id, :integer
  end
end
