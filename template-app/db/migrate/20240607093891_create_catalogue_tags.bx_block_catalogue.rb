# This migration comes from bx_block_catalogue (originally 20201008085059)
# Protected File
class CreateCatalogueTags < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogue_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
