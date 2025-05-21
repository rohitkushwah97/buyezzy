module BxBlockSalesreporting
	class ProductView < ApplicationRecord
		belongs_to :catalogue, class_name: "BxBlockCatalogue::Catalogue"
		belongs_to :user, class_name: 'AccountBlock::Account', optional: true

		before_save :assign_viewed_at, if: :new_record?

		private

		def assign_viewed_at
			self.viewed_at = Time.current
		end
	end
end
