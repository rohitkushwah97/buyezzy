module BxBlockSalesreporting
  class SalesReportService
    REPORT_TYPES = %w[
      sales_report sales_and_traffic_report return_report compare_sales
    ].freeze

    def initialize(start_date, end_date, report_type, seller = nil, sort_by = nil, sort_order = nil)
      @start_date = start_date
      @end_date = end_date
      @report_type = report_type
      @seller = seller
      @sort_order = sort_order
      @sort_by = sort_by
    end

    def call
      report_data = case @report_type
                    when 'sales_report'
                      sales_report
                    when 'sales_and_traffic_report'
                      sales_and_traffic_report
                    when 'return_report'
                      return_report
                    when 'compare_sales'
                      compare_sales_report
                    else
                      { error: 'Invalid report type' }
                    end

      sort_report_data(report_data)
    end

    private

    def sort_report_data(data)
      return data unless @sort_by

      data.sort_by! { |item| item[@sort_by.to_sym] }

      data.reverse! if @sort_order == 'desc'
      data
    end

    def sales_report
      orders.group_by { |order| order.order_placed_at.to_date }.map do |order_placed_at, orders|
        order_items = filter_order_items_by_seller(orders.flat_map(&:order_items))
        catalogues = order_items.map { |item| item.catalogue }
        sessions_total = calculate_sessions_total(catalogues)
        seller_sessions_total = seller_catalogue_sessions
        {
          date: order_placed_at,
          ordered_product_sales: ordered_product_sales(orders),
          units_ordered: units_ordered(orders),
          total_order_item: total_order_items(orders),
          average_sales_per_order_item: average_sales_per_order_items(orders),
          average_units_per_order_item: average_units_per_order_items(orders),
          average_selling_price: average_selling_price(orders),
          order_item_sessions_total: sessions_total,
          order_item_session_percentage: calculate_session_percentage(sessions_total, seller_sessions_total)
        }
      end
    end

    def sales_and_traffic_report
      seller_sessions_total = seller_catalogue_sessions
      orders.flat_map(&:order_items).group_by(&:catalogue_id).map do |catalogue_id, order_items|
        next if @seller && !@seller.catalogue_ids.include?(catalogue_id)

        product = order_items.first.catalogue
        sessions_total = calculate_sessions_total([product])

        {
          parent_besku: product.besku,
          child_besku: product.product_variant_group ? product.product_variant_group.product_besku : "N/A",
          title: product.product_title,
          sku: product.product_variant_group ? product.product_variant_group.product_sku : product.sku,
          sessions_total: sessions_total,
          sessions_percentage: calculate_session_percentage(sessions_total, seller_sessions_total),
          page_views_total: product_views_total(catalogue_id),
          page_views_percentage_total: calculate_page_views_percentage(catalogue_id),
          featured_offer_buy_box_per: featured_offer_buy_box_per(product),
          units_ordered: units_ordered_by_items(order_items),
          units_ordered_percentage: units_ordered_percentage(order_items, orders),
          ordered_product_sales: ordered_items_product_sales(order_items),
          total_order_item: order_items.count
        }
      end
    end

    def return_report
      orders.group_by { |order| order.order_placed_at.to_date }.map do |order_placed_at, orders|
        {
          date: order_placed_at,
          ordered_product_sales: ordered_product_sales(orders),
          units_ordered: units_ordered(orders),
          total_order_item: total_order_items(orders),
          units_refunded: units_refunded(orders),
          refund_rate: refund_rate(orders),
          feedback_received: feedback_received(orders),
          negative_feedback_received: negative_feedback_received(orders),
          received_negative_feedback_rate: received_negative_feedback_rate(orders),
          a_z_claims_granted: a_z_claims_granted(orders),
          claims_amount: claims_amount(orders)
        }
      end
    end

    def compare_sales_report
      {
        today_so_far: calculate_metrics(Date.today),
        yesterday: calculate_metrics(Date.yesterday),
        same_day_last_week: calculate_metrics(Date.today - 7.days),
        same_day_last_year: calculate_metrics(Date.today - 1.year),
        percentage_change_from_yesterday: calculate_percentage_change(Date.today, Date.yesterday),
        percentage_change_from_same_day_last_week: calculate_percentage_change(Date.today, Date.today - 7.days),
        percentage_change_from_same_day_last_year: calculate_percentage_change(Date.today, Date.today - 1.year)
      }
    end

    def calculate_metrics(date)
      orders_for_date = orders_for(date)
       { 
        total_order_item: total_order_items(orders_for_date),
        units_ordered: units_ordered(orders_for_date),
        ordered_product_sales: ordered_product_sales(orders_for_date),
        average_units_or_order_item: average_units_per_order_items(orders_for_date),
        average_sales_or_order_item: average_sales_per_order_items(orders_for_date)
       }
    end

    def orders_for(date)
      build_order_query(date.beginning_of_day, date.end_of_day)
    end

    def calculate_percentage_change(current_date, comparison_date)
      current_metrics = calculate_metrics(current_date)
      comparison_date = calculate_metrics(comparison_date)

      { 
        total_order_item: percentage_change(current_metrics[:total_order_item], comparison_date[:total_order_item]),
        units_ordered: percentage_change(current_metrics[:units_ordered], comparison_date[:units_ordered]),
        ordered_product_sales: percentage_change(current_metrics[:ordered_product_sales], comparison_date[:ordered_product_sales]),
        average_units_or_order_item: percentage_change(current_metrics[:average_units_or_order_item], comparison_date[:average_units_or_order_item]),
        average_sales_or_order_item: percentage_change(current_metrics[:average_sales_or_order_item], comparison_date[:average_sales_or_order_item])
       }
    end

    def percentage_change(current_value, previous_value)
      return 0 if previous_value.zero?

      ((current_value - previous_value) / previous_value.to_f * 100).round(2)
    end

    def units_refunded(orders)
      if @seller
        order_items = filter_order_items_by_seller(orders.flat_map(&:order_items))
        order_items.select {|order_item| order_item.order_status&.status == 'refunded' }.sum(&:quantity)
      else
        orders.sum {|order| order.order_items.select {|order_item| order_item.order_status&.status == 'refunded' }.sum(&:quantity) }
      end
    end

    def refund_rate(orders)
      units_ordered(orders).zero? ? 0 : (units_refunded(orders).to_f / units_ordered(orders) * 100).round(2)
    end

    def feedback_received(orders)
      catalogue_ids = get_catalogue_ids(orders).uniq
      BxBlockCatalogue::Review.where(review_type: 'product', catalogue_id: catalogue_ids).count
    end

    def negative_feedback_received(orders)
      catalogue_ids = get_catalogue_ids(orders).uniq
      BxBlockCatalogue::Review.where(review_type: 'product', catalogue_id: catalogue_ids).select {|review| review.rating < 3 }.count
    end

    def received_negative_feedback_rate(orders)
      total_feedback = feedback_received(orders)
      total_feedback.zero? ? 0 : (negative_feedback_received(orders).to_f / total_feedback * 100).round(2)
    end

    def a_z_claims_granted(orders)
      if @seller
        order_items = filter_order_items_by_seller(orders.flat_map(&:order_items))
        order_items.select {|order_item| order_item.order_status&.status == 'refunded' }.count
      else
        orders.sum {|order| order.order_items.select {|order_item| order_item.order_status&.status == 'refunded' }.count }
      end
    end

    def claims_amount(orders)
      if @seller
        order_items = filter_order_items_by_seller(orders.flat_map(&:order_items))
        order_items.select {|order_item| order_item.order_status&.status == 'refunded' }.sum(&:price)
      else
        orders.sum {|order| order.order_items.select {|order_item| order_item.order_status&.status == 'refunded' }.sum(&:price) }
      end
    end

    def ordered_product_sales(orders)
      # total sales revenue
      order_items = filter_order_items_by_seller(orders.flat_map(&:order_items))
      order_items.sum { |order_item| order_item.price * order_item.quantity }.round(2)
    end

    def ordered_items_product_sales(order_items)
      order_items.sum(&:price).round(2)
    end

    def units_ordered(orders)
      # total items sold including quantity
      order_items = filter_order_items_by_seller(orders.flat_map(&:order_items))
      order_items.sum(&:quantity)
    end

    def units_ordered_by_items(order_items)
      # total items sold including quantity
      order_items = filter_order_items_by_seller(order_items) if @seller
      order_items.sum(&:quantity)
    end

    def units_ordered_percentage(order_items, orders)
      total_units = units_ordered(orders)
      return 0 if total_units.zero?
      # units ordered based on order items / all orders unit count
      (units_ordered_by_items(order_items) / total_units.to_f * 100).round(2)
    end

    def total_order_items(orders)
      # total items sold
      get_catalogue_ids(orders).count
    end

    def average_sales_per_order_items(orders)
      # average sale per uniq product items
      # total revenue / total uniq items
      unique_count = get_catalogue_ids(orders).uniq.count
      total_sales = ordered_product_sales(orders)
      return 0 if unique_count.zero?

      (total_sales / unique_count).round(2)
    end

    def average_units_per_order_items(orders)
      # average quantity per uniq product items
      # total items / uniq product items
      unique_count = get_catalogue_ids(orders).uniq.count
      return 0 if unique_count.zero?

      units_ordered(orders) / unique_count
    end

    def featured_offer_buy_box_per(catalogue)
      # how many items sold by the seller 1 item A and other sellers item A(this is identified by same besku)
      order_ids = BxBlockShoppingCart::Order.where.not(order_placed_at: nil).pluck(:id)
      order_items = BxBlockShoppingCart::OrderItem.includes(:catalogue).where(catalogues: { besku: catalogue.besku }, order_id: order_ids)
      total_besku_products_count = order_items.sum(:quantity)
      return 0 if total_besku_products_count.zero?

      seller_besku_products_count = order_items.where(catalogues: { seller_id: catalogue.seller_id }).sum(:quantity)

      (seller_besku_products_count.to_f / total_besku_products_count * 100).round(2)
    end

    def get_catalogue_ids(orders)
      catalogue_ids = orders.map {|order| order.catalogue_ids }.flatten
      if @seller
       catalogue_ids = catalogue_ids.select {|cat| @seller.catalogue_ids.include?(cat) }
      end

      catalogue_ids
    end

    def average_selling_price(orders)
      # average selling price from total revenue
      # total revenue / total order items
      total_items = total_order_items(orders)
      return 0 if total_items.zero?

      (ordered_product_sales(orders) / total_items).round(2)
    end

    def orders
      @orders ||= build_order_query(@start_date.beginning_of_day, @end_date.end_of_day)
    end

    def build_order_query(start_date, end_date)
      query = BxBlockShoppingCart::Order.where(order_placed_at: start_date..end_date).order(order_placed_at: :desc)
      if @seller
        query = query.includes(order_items: { catalogue: [:seller, :product_content] })
        .where(catalogues: { seller_id: @seller.id })
      else
        query = query.includes(order_items: { catalogue: [:seller, :product_content] })
      end
      query
    end

    def filter_order_items_by_seller(order_items)
      # filter items by seller
      return order_items unless @seller
      order_items.select { |item| item.catalogue.seller_id == @seller.id } 
    end

    def seller_catalogue_sessions
      seller_catalogues = @seller ? @seller.catalogues : []
      calculate_sessions_total(seller_catalogues)
    end

    def calculate_sessions_total(catalogues)
      product_views = ProductView.where(catalogue_id: catalogues.pluck(:id))

      session_count = product_views.group_by(&:catalogue_id).map do |catalogue_id, views|
        views.group_by {|view| view.created_at.to_date }.count
      end.sum
      session_count
    end

    def calculate_session_percentage(sessions_total, all_order_session_total)
      return 0 if all_order_session_total.zero?
      (sessions_total.to_f / all_order_session_total * 100).round(2)
    end

    def product_views_total(catalogue_id)
      ProductView.where(catalogue_id: catalogue_id).count
    end

    def calculate_page_views_percentage(catalogue_id)
      if @seller
        # total views of seller product
        seller_product_ids = @seller.catalogue_ids
        total_page_views = ProductView.where(catalogue_id: seller_product_ids).count
      else
        # total all product views
        total_page_views = ProductView.count
      end

      product_page_views = product_views_total(catalogue_id)
      return 0 if total_page_views.zero?

      #perticular product view / total product views(seller/all) 
      (product_page_views.to_f / total_page_views * 100).round(2)
    end

  end
end
