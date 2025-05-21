# This migration comes from bx_block_categories (originally 20210510122614)
# Protected File
# frozen_string_literal: true

class AddRankIntoCategoryAndSubCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :rank, :integer
    add_column :sub_categories, :rank, :integer
  end
end
