class CreateBxBlockContentflagFlagCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_contentflag_flag_categories do |t|
      t.string :reason

      t.timestamps
    end
  end
end
