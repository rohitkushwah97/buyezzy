module BxBlockCatalogue
	class CatalogueOfferSerializer < BuilderBase::BaseSerializer
		attributes :id, :price_info, :sale_price, :barcode_id, :bar_code_info, :sale_schedule_from, :sale_schedule_to, :warranty, :comments, :status

		attributes :barcode do |object|
			if object.barcode
				object.barcode.serializable_hash(only: [:id, :bar_code])
			end
		end

		attributes :catalogue do |object|
			if object.catalogue
				object.catalogue.serializable_hash(only: [:sku, :besku])
			end
		end

	end
end
