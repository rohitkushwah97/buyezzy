module BxBlockDashboard
	class AuthorFavoriteBook < ApplicationRecord
		self.table_name = :author_favorite_books

		has_many :favorite_book_catalogues, class_name: "BxBlockDashboard::AuthorFavoriteBookCatalogue", dependent: :destroy
		accepts_nested_attributes_for :favorite_book_catalogues, allow_destroy: true
		validates :title, presence: true
		before_save :reset_other_statuses, if: :status_changed_to_true?
		validate :minimum_8_products

		private

		def minimum_8_products
			selections = favorite_book_catalogues.reject { |s| s.marked_for_destruction? }
			errors.add(:favorite_book_catalogues, "must have at least 8 unique products") if selections.size < 8
			
			product_ids = selections.map(&:catalogue_id)
			errors.add(:favorite_book_catalogues, "cannot have duplicate products") if product_ids.uniq.size != product_ids.size
		end

		def status_changed_to_true?
			status_changed? && status == true
		end

		def reset_other_statuses
			self.class.where.not(id: id).update_all(status: false)
		end
	end
end