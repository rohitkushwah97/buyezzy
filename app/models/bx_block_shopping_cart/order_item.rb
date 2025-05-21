module BxBlockShoppingCart
  class OrderItem < ApplicationRecord
    self.table_name = :shopping_cart_order_items
    belongs_to :order, class_name: 'BxBlockShoppingCart::Order', foreign_key: :order_id
    belongs_to :order_status, class_name: 'BxBlockOrderManagement::OrderStatus', foreign_key: :order_status_id, optional: true
    belongs_to :catalogue, class_name: 'BxBlockCatalogue::Catalogue', foreign_key: :catalogue_id
    has_one :seller, through: :catalogue
    belongs_to :product_variant_group, class_name: 'BxBlockCatalogue::ProductVariantGroup', optional: true
    has_many :return_reason_details, class_name: 'BxBlockShoppingCart::ReturnReasonDetail', foreign_key: :shopping_cart_order_item_id, dependent: :destroy
    has_and_belongs_to_many :return_exchange_requests, class_name: 'BxBlockShoppingCart::ReturnExchangeRequest', join_table: :order_items_return_exchange_requests
    has_many :invoice_billings, class_name: 'BxBlockInvoicebilling::InvoiceBilling', dependent: :destroy
    has_many :review_and_ratings, class_name: "BxBlockCatalogue::Review", foreign_key: :order_item_id, dependent: :destroy
    has_one :shipped_order_detail, class_name: 'BxBlockShoppingCart::ShippedOrderDetail', dependent: :destroy
    validate :check_stock_availability, on: :create
    scope :available_status, -> {
      joins(:order_status).where(order_statuses: { name: ['Processing', 'Shipped', 'Delivered'] })
    }

    before_save :assign_price_to_order_item
    after_save :update_order_total
    after_destroy :update_order_total

    validate :order_can_be_updated
    after_update :notify_sellers_if_returned, :notify_sellers_if_return_completed, :notify_buyer_if_pickup

    after_update :notify_buyer_if_shipped, :update_stock_if_catalogue_return


    def notify_sellers_if_returned
      send_email_notification_if_status_changed('return', 'Refund/Return Notification', 'return_refund_notification')
      send_email_notification_if_status_changed('return', 'Return Request Accepted', 'return_request_accepted_notification', order.customer)
    end

    def notify_buyer_if_pickup
      send_email_notification_if_status_changed('pickup_initiated', 'Return Picked Up', 'return_pickup_information_notification', order.customer)
    end

    def notify_buyer_if_shipped
      if self.order_status&.status == 'shipped'
        send_email_notification_if_status_changed('shipped', 'Your order is shipped', 'shipment_confirmation_notification', self.order.customer)
        send_email_notification_if_status_changed('shipped', 'Out for Delivery', 'out_for_delivery_notification', self.order.customer)
      end
    end

    def notify_sellers_if_return_completed
      send_email_notification_if_status_changed('refunded', "Return Completed: Order ID - #{order.order_number}", 'return_complete_notification')
      send_email_notification_if_status_changed('refund_initiated', "Return Completed", 'return_completed_buyer_notification', order.customer)
      send_email_notification_if_status_changed('refund_initiated', "Refund Initiated - (#{catalogue&.product_title})", 'refund_initiated_notification', order.customer)
    end

    def send_email_notification_if_status_changed(expected_status, subject, template, buyer = nil)
      if saved_change_to_order_status_id? && order_status&.status == expected_status
        account = buyer ? buyer : catalogue.seller
        BxBlockEmailNotifications::SendEmailNotificationService
          .with(account: account, subject: subject, file: template, order_item: self, order: order)
          .notification.deliver_later
      end
    end

    def order_can_be_updated
      if ['cancelled', 'completed'].include?(order&.order_status&.name)
        errors.add(:order, "has already been #{order.order_status&.name}")
      end
    end

    def assign_price_to_order_item
      discount_price = assign_discount_to_order

      if discount_price > 0
        self.price = discount_price
      else
        self.price = catalogue.product_content&.retail_price&.to_f&.round(2) || 0.0
      end
    end

    def active_offer
      if catalogue.catalogue_offer&.active?
        catalogue.catalogue_offer
      else
        nil
      end
    end

    def active_approved_deal
      seller_deal = catalogue.deal_catalogues.where(status: 'approved').last
      seller_deal if seller_deal&.deal&.active?
    end

    def assign_discount_to_order
      retail_price = catalogue.product_content&.retail_price.to_f

      if active_offer.present?
        sale_price = active_offer.sale_price.to_f.round(2)
        self.discount_price = (sale_price > retail_price) ? 0 : -(retail_price - sale_price)
        return sale_price
      end

      if active_approved_deal.present?
        if active_approved_deal.deal.discount_type == 'flat'
          deal_price = active_approved_deal.deal_price.to_f.round(2)
          self.discount_price = (deal_price > retail_price) ? 0 : -(retail_price - deal_price)
          return deal_price

        elsif active_approved_deal.deal.discount_type == 'percentage'
          discount = (retail_price * active_approved_deal.deal.discount_value / 100.0).round(2)
          self.discount_price = -(discount)
          return (retail_price - discount).round(2)
        else
           0.0
        end
      end

      self.discount_price = 0.0
      return 0.0
    end

    def update_order_total
      if order && order.valid?
        order.update(
          total_fees: calculate_total_price,
          total_items: count_total_items,
          discount: calculate_total_discount,
          total_tax: calculate_total_tax,
          final_price: calculate_final_price.round(2)
          )
      else
        errors.add(:base, 'Order is not valid')
      end
    end

    def calculate_total_fees
      order.order_items.map {|item| item.price*item.quantity }.sum.round(2)
    end

    def calculate_total_price
      order.order_items.map { |item| (item&.catalogue&.product_content&.retail_price&.to_f || 0) * item.quantity }.sum.round(2)
    end

    def count_total_items
      order.order_items.map {|item| item.quantity }.sum
    end

    def calculate_total_discount
      order.order_items.map do |item|
        retail_price = item.catalogue.product_content&.retail_price.to_f
        discount_price = item.assign_discount_to_order
        if discount_price.zero? || discount_price >= retail_price
          0.0
        else
          discount_amount = (retail_price - discount_price) * item.quantity
          discount_amount.round(2)
        end
      end.sum
    end

    def calculate_final_price
      total_price = calculate_total_price
      total_discount = calculate_total_discount
      total_tax = calculate_total_tax

      (total_price - total_discount + total_tax).round(2)
    end

    def calculate_final_discount_price
      final_discount = 0
        order.order_items.each do |item|
          if item.discount_price > 0
            final_discount += (item.discount_price*item.quantity)
          else
            final_discount += (item.price*item.quantity)
          end
        end
      final_discount
    end

    def calculate_total_tax
      order.order_items.map {|item| item.quantity*item.taxable_value }.reject(&:blank?).sum.round(2)
    end

    def self.get_favourites(object)
      favourites = nil

      favourites = object.product_variant_group&.favourites if object.product_variant_group
      favourites ||= object.catalogue&.favourites if object.catalogue.present?

      favourites&.select { |fav| fav.user_id == object.order.customer_id }&.last
    end

    def check_stock_availability
      available_stock = catalogue&.stocks || 0

      if quantity > available_stock
        errors.add(:quantity, "This seller has only #{available_stock} of these available.")
      end
    end

    def update_stock_if_catalogue_return
      if catalogue&.present? && order_status&.status == 'qc_passed' || order_status&.status == 'rejected'
        catalogue.increment!(:stocks, quantity.to_i) 
        catalogue.warehouse_catalogues&.first&.increment!(:stocks, quantity.to_i)
      end
    end
    
  end
end
