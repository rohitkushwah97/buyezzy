module BxBlockOrderManagement
	class StockIntake < ApplicationRecord
		self.table_name = :stock_intakes
		belongs_to :catalogue, class_name: 'BxBlockCatalogue::Catalogue'
		belongs_to :seller, class_name: "AccountBlock::Account"

		validates :stock_value, :stock_qty, presence: true, numericality: { greater_than: 0 }
		validate :ship_date_must_be_today_or_future
		validate :receiving_date_must_be_after_ship_date_and_today

		private

		def ship_date_must_be_today_or_future
			if ship_date.blank? || ship_date < Date.today
				errors.add(:ship_date, "must be today or a future date")
			end
		end

		def receiving_date_must_be_after_ship_date_and_today
			if receiving_date.blank? || receiving_date < ship_date || receiving_date < Date.today
				errors.add(:receiving_date, "must be after ship date and today")
			end
		end

	end
end