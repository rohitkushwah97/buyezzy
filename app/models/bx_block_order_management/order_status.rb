# frozen_string_literal: true

# == Schema Information
#
# Table name: order_statuses
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :string
#  active     :boolean          default(TRUE)
#  event_name :string
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module BxBlockOrderManagement
  class OrderStatus < BxBlockOrderManagement::ApplicationRecord
    self.table_name = :order_statuses

    has_many :orders, class_name: "BxBlockShoppingCart::Order", dependent: :nullify
    has_many :order_items, class_name: "BxBlockShoppingCart::OrderItem", dependent: :nullify

    validates :name, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }, presence: true


    before_save :add_status

    scope :new_statuses, lambda {
      where.not(status: %i[
        in_cart
        created
        placed
        confirmed
        in_transit
        delivered
        cancelled
        refunded
        payment_failed
        returned
        payment_pending
      ])
    }

    USER_STATUSES = %w[
      in_cart
      created
      placed
      payment_failed
      payment_pending
    ].freeze

    CUSTOM_STATUSES = %w[
      in_cart
      created
      placed
      confirmed
      in_transit
      delivered
      cancelled
      refunded
      payment_failed
      returned
      payment_pending
    ].freeze

    private

    def add_status
      self.status = name.to_s.downcase.parameterize.underscore unless status.present?
      # self.event_name = name.to_s.downcase.parameterize.underscore unless event_name.present?
    end
  end
end
