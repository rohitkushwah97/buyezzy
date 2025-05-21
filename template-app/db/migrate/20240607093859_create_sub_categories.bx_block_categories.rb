# This migration comes from bx_block_categories (originally 20201005124054)
# Protected File
# frozen_string_literal: true

class CreateSubCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
