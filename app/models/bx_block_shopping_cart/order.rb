module BxBlockShoppingCart
  class Order < ApplicationRecord
    include Wisper::Publisher
    self.table_name = :shopping_cart_orders

    # BUFFER_TIME = 20 #in minute
    ORDER_NUMBER_FORMAT = "0000-0000000000"

    #order status are
    #upcomming = 'scheduled', ongoing = 'on_going', history = 'cancelled or completed
    # enum status: { scheduled: 0, on_going: 1, cancelled: 2, completed: 3 }

    has_many :order_items, class_name: 'BxBlockShoppingCart::OrderItem', dependent: :destroy
    belongs_to :shipping_address, class_name: "AccountBlock::UserDeliveryAddress", optional: true, foreign_key: :address_id
    has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue", through: :order_items
    has_many :sellers, class_name: "AccountBlock::Account", through: :catalogues, source: :seller
    # belongs_to :address, class_name: 'BxBlockAddress::Address', optional: true
    belongs_to :customer, class_name: 'AccountBlock::Account', foreign_key: :customer_id

    belongs_to :coupon_code, class_name: "BxBlockCouponCg::CouponCode", optional: true

    belongs_to :order_status, class_name: 'BxBlockOrderManagement::OrderStatus', foreign_key: :order_status_id, optional: true
    has_many :delivery_requests, class_name: 'BxBlockOrderManagement::DeliveryRequest', dependent: :nullify
    has_many :shipped_order_details, class_name: 'BxBlockShoppingCart::ShippedOrderDetail', dependent: :destroy
    has_many :return_exchange_requests, class_name: 'BxBlockShoppingCart::ReturnExchangeRequest', dependent: :destroy
    has_many :invoice_billings, class_name: 'BxBlockInvoicebilling::InvoiceBilling', dependent: :destroy

    validate :check_order_status, if: Proc.new {|a| !a.new_record?}
    validate :check_warehouse_catalogue_stocks, on: :update, if: -> { order_status&.status == 'ordered' }

    before_create :assign_default_order_status
    # after_create :set_current_order
    # after_update :update_current_order
    after_commit :set_or_update_current_order

    before_create :add_order_number

    scope :completed, -> { joins(:order_status).where('order_statuses.status': 'completed') }
    scope :completed_cancelled, -> { joins(:order_status).where(order_statuses: { status: ['delivered','completed', 'cancelled'] }) }
    

    before_update :update_order_placed_at, if: -> { order_status&.status == 'ordered' }
    before_update :update_delivered_at, if: -> { order_status&.status.in?(['delivered', 'completed']) }

    after_create :assign_default_shipping_address
    after_update :increment_purchase_count_on_product, if: -> { order_status&.status.in?(['ordered']) }
    after_update :update_stocks, if: -> { order_status&.status.in?(['ordered']) }
    after_update :notify_seller_if_ordered, :notify_seller_if_delivered
    after_update :update_shipping_address, if: -> { order_status&.status.in?(['ordered']) && shipping_first_name.nil? }

    # scope :completed_order, -> { where(order_status.status: 'completed') }

    private

    def notify_seller_if_ordered
      send_email_notification_if_status_changed('ordered', 'Your Product Is Selling', 'product_sale_notification')
      notify_seller_if_payment_done
      send_email_notification_if_status_changed('ordered', 'Order Confirmation', 'order_placement_notification', self.customer)
    end

    def notify_seller_if_payment_done
      send_email_notification_if_status_changed('ordered', 'Payment Processed', 'payment_notification')
    end

    def notify_seller_if_delivered
      send_email_notification_if_status_changed('delivered', 'Your product is delivered', 'product_delivery_notification')
      send_email_notification_if_status_changed('delivered',"Order Delivered (#{self.order_number})",'order_delivered_successfully_notification', self.customer)
      send_email_notification_if_status_changed('delivered',"Rate your delivered products – #{self.order_number}",'rate_your_delivered_product_notification', self.customer)
    end

    # def notify_buyer_if_shipped
    #   send_email_notification_if_status_changed('shipped', 'Your order is shipped', 'shipment_confirmation_notification', self.customer)
    #   send_email_notification_if_status_changed('shipped', 'Out for Delivery', 'out_for_delivery_notification', self.customer)
    # end

    def send_email_notification_if_status_changed(expected_status, subject, template, buyer = nil)
      if saved_change_to_order_status_id? && order_status&.status == expected_status
        order_items.includes(:catalogue).each do |order_item|
          account = buyer ? buyer : order_item.catalogue.seller
          BxBlockEmailNotifications::SendEmailNotificationService
          .with(account: account, subject: subject, file: template, order_item: order_item, order: self)
          .notification.deliver_now
        end
      end
    end

    def assign_default_order_status
      self.order_status = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Scheduled')
      self.status = 'scheduled'
    end

    def check_order_status
      status_ids = BxBlockOrderManagement::OrderStatus.where(status: ['completed', 'ordered']).map(&:id)
      # return if shipping_first_name_changed?
      if order_status_id_was.in?(status_ids) && order_status&.status.in?(['scheduled', 'on_going', 'ordered'])
          errors.add(:invalid_request, 'Cannot update the order status back to scheduled, on_going, or ordered once it is completed or ordered')
      end
    end

    def check_warehouse_catalogue_stocks
      out_of_stock_items = order_items.select do |order_item|
        if order_item.catalogue
          order_item.catalogue.warehouse_catalogues.any? { |wc| wc.stocks < order_item.quantity }
        end
      end

      if out_of_stock_items.any?
        out_of_stock_details = out_of_stock_items.map { |item| { id: item.catalogue_id, product_title: item.catalogue.product_title } }
        errors.add(:order_items, out_of_stock: out_of_stock_details)
      end
    end

    def set_or_update_current_order
      return unless customer.present?

      if order_status && order_status.status.in?(%w[on_going scheduled])
        customer.current_order = self.id
      else
        customer.current_order = nil
      end

      if customer.save
        return
      else
        errors.add(:customer, "Failed to update current order for customer: #{customer.errors.full_messages}")
        raise ActiveRecord::Rollback
      end
    end

    def add_order_number
      self.order_number = Order.next_order_number
    end

    def self.next_order_number
        return ORDER_NUMBER_FORMAT.succ if Order.count.zero?

        last_order_number = Order.last.order_number
        numeric_part = last_order_number.split('-')[1].to_i
        next_numeric_part = numeric_part.succ

        next_order_number = "#{next_numeric_part.to_s.rjust(10, '0')}"
        "#{ORDER_NUMBER_FORMAT.split('-')[0]}-#{next_order_number}"
    end

    def update_order_placed_at
      self.order_placed_at = Time.current unless order_placed_at.present?
    end

    def update_delivered_at
      self.delivered_at = Time.current unless delivered_at.present?
    end

    def assign_default_shipping_address
      shipping_address_id = nil

      if customer&.user_delivery_addresses&.any?
        user_address = customer.user_delivery_addresses.find_by(is_default: true)

          shipping_address_id = user_address&.id
      end
        update(address_id: shipping_address_id)
    end

    #to store static shipped address after ordered
    def update_shipping_address
      if shipping_address
        update_columns(
          shipping_first_name: shipping_address.first_name,
          shipping_last_name: shipping_address.last_name,
          shipping_address_1: shipping_address.address_1,
          shipping_address_2: shipping_address.address_2,
          shipping_city: shipping_address.city,
          shipping_state: shipping_address.state,
          shipping_phone_number: shipping_address.phone_number,
          shipping_zip_code: shipping_address.zip_code
          )
      end
    end

    def increment_purchase_count_on_product
      return unless catalogues.present?

      catalogues.each do |catalogue|
        catalogue.increment!(:purchased_count)
      end
    end

    def update_stocks
      order_items.each do |order_item|
        catalogue = order_item.catalogue
        next unless catalogue.present?

        if catalogue.warehouse_catalogues.present?
          catalogue.warehouse_catalogues.each do |warehouse_catalogue|
            new_stock = warehouse_catalogue.stocks - order_item.quantity
            if new_stock <= 0
              warehouse_catalogue.update!(stocks: 0)
            else
              warehouse_catalogue.decrement!(:stocks, order_item.quantity)
            end
          end
        end

        catalogue.update_total_stocks
      end
    end
  end
end
