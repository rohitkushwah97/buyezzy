module BxBlockCatalogue
	class Deal < ApplicationRecord
		self.table_name = :deals
		enum discount_type: {
			percentage: 'percentage',
			flat: 'flat'
		}
		validates :deal_name, presence: true, length: { maximum: 50 }
		validates :deal_code, presence: true, length: { maximum: 50 }
		validates :start_date,:end_date,:discount_type, presence: true
		validate :end_date_must_be_after_start_date
		validate :start_date_must_be_after_today
		has_many :deal_catalogues, class_name: "BxBlockCatalogue::DealCatalogue", dependent: :destroy
		has_many :catalogues, through: :deal_catalogues, class_name: "BxBlockCatalogue::Deal"
		has_many :banners, class_name: "BxBlockDashboard::Banner", dependent: :destroy
		has_many :weekly_deals, class_name: "BxBlockDashboard::WeeklyDeal", dependent: :destroy
		validates :discount_value, presence: true, numericality: { greater_than_or_equal_to: 0 }
		after_save :update_deal_catalogue_statuses, if: :saved_change_to_status?
		after_commit :schedule_expiry_job, if: -> { active? }
		scope :active_deals, -> { where("end_date >= ? AND status != ?", Date.today, false) }


		def active?
			end_date >= Date.today && status
		end

		private

		def schedule_expiry_job
			ExpireOffersAndDealsJob.set(wait_until: end_date.to_time).perform_later
		end

		def start_date_must_be_after_today
			if start_date.present? && start_date < Date.today
				errors.add(:start_date, 'must be today or after today')
			end
		end

		def end_date_must_be_after_start_date
			return if start_date.blank? || end_date.blank?

			if end_date < start_date
				errors.add(:end_date, "must be after the start date")
			end
		end

		def update_deal_catalogue_statuses
			if saved_change_to_status? && !status
				deal_catalogues.update_all(status: :expired)
			end
		end
	end
end