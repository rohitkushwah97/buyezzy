# This migration comes from bx_block_categories (originally 20201005095712)
# Protected File
# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
