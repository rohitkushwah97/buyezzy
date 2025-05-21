class RemoveSellerIdAddSellerToCatalogueVariants < ActiveRecord::Migration[6.0]
  def change
  	BxBlockCatalogue::CatalogueVariant.delete_all
  	remove_column :catalogue_variants, :seller_id, :bigint
    add_reference :catalogue_variants, :seller, null: false, foreign_key: { to_table: :accounts }
  end
end
