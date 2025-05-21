class AddForeignKeyConstraintToCatalogueProdcontent < ActiveRecord::Migration[6.0]
  def change
  	reversible do |dir|
      dir.up do
        remove_foreign_key :barcodes, column: :catalogue_id
        remove_foreign_key :catalogue_offers, column: :catalogue_id
        remove_foreign_key :deal_catalogues, column: :catalogue_id
        remove_foreign_key :product_contents, column: :catalogue_id

        add_foreign_key :barcodes, :catalogues, column: :catalogue_id, on_delete: :cascade
        add_foreign_key :catalogue_offers, :catalogues, column: :catalogue_id, on_delete: :cascade
        add_foreign_key :deal_catalogues, :catalogues, column: :catalogue_id, on_delete: :cascade
        add_foreign_key :product_contents, :catalogues, column: :catalogue_id, on_delete: :cascade
      end
    end
  end
end
