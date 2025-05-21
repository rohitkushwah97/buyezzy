class AddForeignKeyConstraintToProductContent < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        remove_foreign_key :image_urls, column: :product_content_id
        remove_foreign_key :feature_bullets, column: :product_content_id
        remove_foreign_key :special_features, column: :product_content_id
        remove_foreign_key :shipping_details, column: :product_content_id
        remove_foreign_key :size_and_capacities, column: :product_content_id

        add_foreign_key :image_urls, :product_contents, column: :product_content_id, on_delete: :cascade
        add_foreign_key :feature_bullets, :product_contents, column: :product_content_id, on_delete: :cascade
        add_foreign_key :special_features, :product_contents, column: :product_content_id, on_delete: :cascade
        add_foreign_key :shipping_details, :product_contents, column: :product_content_id, on_delete: :cascade
        add_foreign_key :size_and_capacities, :product_contents, column: :product_content_id, on_delete: :cascade
      end
    end
  end
end
