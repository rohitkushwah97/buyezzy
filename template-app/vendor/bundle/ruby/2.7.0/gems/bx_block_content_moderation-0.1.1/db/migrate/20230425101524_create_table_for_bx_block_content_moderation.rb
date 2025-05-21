class CreateTableForBxBlockContentModeration < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_content_moderation_contents do |t|
    	t.text :text_content
    	t.boolean :is_text_approved
        t.boolean :is_image_approved
    	t.boolean :is_active
    	t.bigint :created_by 
    	t.string :updated_by
    	t.timestamps
    end
  end
end
