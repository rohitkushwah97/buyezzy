module BxBlockCustomAds
  class Advertisement < ApplicationRecord

    self.table_name = :advertisements
    # belongs_to :seller_account, class_name: "BxBlockCustomForm::SellerAccount"

    enum status: { inactive: 0, active: 1 }
    enum advertisement_for: { seller: 0, user: 1 }

    has_one_attached :banner_ad, dependent: :destroy

    validates :name, :description, :start_at, :expire_at, presence: true

    # before_create :add_status

    # after_create :notify_admin

    # def add_status
    #   self.status = 0
    # end

    # def notify_admin
      # AdvertisementMailer.notify_admin(advertisement:self).deliver
    # end

    validate :start_at_in_future
    validate :expire_at_after_start_at, on: :create

    private

    def start_at_in_future
      errors.add(:start_at, "Start date should be in the future") if start_at.present? && start_at < Date.today
    end

    def expire_at_after_start_at
      return unless start_at && expire_at

      if expire_at < start_at
        errors.add(:expire_at, "Expiry date should be after the start date")
      elsif expire_at < Date.today
        errors.add(:expire_at, "Expiry date should be in the future")
      end
    end
  end
end
