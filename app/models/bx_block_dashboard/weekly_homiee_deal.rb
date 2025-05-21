module BxBlockDashboard
	class WeeklyHomieeDeal < ApplicationRecord
		self.table_name = :weekly_homiee_deals
		has_many :weekly_deals, class_name: "BxBlockDashboard::WeeklyDeal", dependent: :destroy
		accepts_nested_attributes_for :weekly_deals, allow_destroy: true

		validate :start_time_must_be_today_or_later_and_present
		validate :end_date_must_be_today_or_later_and_present

		validate :max_weekly_deals

		before_save :reset_other_statuses, if: :status_changed_to_true?
		scope :active_homiee_deals, -> { where("end_time >= ? AND status != ?", Date.today, false) }

		private

		def max_weekly_deals
			selections = weekly_deals.reject { |s| s.marked_for_destruction? }
			if selections.size != 3
				errors.add(:weekly_deals, "must be exactly 3 and cannot be blank")
			end
		end

		def end_date_must_be_today_or_later_and_present
			if end_time.blank? || (end_time.to_date < Date.current) || (end_time <= Time.current)
				errors.add(:end_date, "must be today or after start time")
			end
		end

		def start_time_must_be_today_or_later_and_present
			if start_time.blank? || (start_time < Date.current)
				errors.add(:start_time, "must be today or later")
			end
		end

		def status_changed_to_true?
			status_changed? && status == true
		end

		def reset_other_statuses
			self.class.where.not(id: id).update_all(status: false)
		end

	end
end