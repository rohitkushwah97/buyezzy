class BackfillFinalPriceInCatalogues < ActiveRecord::Migration[6.0]
	disable_ddl_transaction!

	def up
		say_with_time "Backfilling final_price for catalogues" do
			BxBlockCatalogue::Catalogue.find_in_batches(batch_size: 500) do |catalogues|
				catalogues.each do |catalogue|
					catalogue.update_column(:final_price, catalogue.calculate_effective_price)
				end
			end
		end
	end

  	# This migration does not require a rollback step, as it only backfills data.
	def down
		 # No changes needed on rollback since this migration only updates existing data.
	end
end
