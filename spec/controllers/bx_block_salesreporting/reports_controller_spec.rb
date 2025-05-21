require 'rails_helper'

RSpec.describe BxBlockSalesreporting::ReportsController, type: :controller do


  before(:all) do
   @seller = create(:account, user_type: "seller")
    @token = BuilderJsonWebToken.encode(@seller.id)
    @catalogue = create(:catalogue, seller: @seller)
    @customer = create(:account, user_type: "buyer")
    @order_status_on_going = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'On Going')
    @order_status_ordered = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Ordered')
    @order_status_delivered = BxBlockOrderManagement::OrderStatus.find_or_create_by(name: 'Delivered')
    @order = create(:shopping_cart_order, customer: @customer, order_status: @order_status_on_going)
    @order_item = create(:shopping_cart_order_item, catalogue: @catalogue, order: @order)
    @order.order_items << @order_item
    @order.update!(order_status: @order_status_ordered)
    @order.update!(order_status: @order_status_delivered)
    @product_view = create(:product_view, catalogue: @catalogue, user: @customer)
    @ordered_product_sales = @order.final_price
    @units_ordered = @order.total_items || 0
    @units_ordered_by_items = @order_item.quantity
    @total_order_item = @order.order_items.count
    @average_sales_per_order_item = @ordered_product_sales / @total_order_item
    @average_units_per_order_item = @units_ordered / @total_order_item
    @average_selling_price = @ordered_product_sales / @total_order_item
    @page_views_total = BxBlockSalesreporting::ProductView.where(catalogue_id: @catalogue.id).count
    @page_views_percentage = 100 
    @order_date = Date.today.strftime('%Y-%m-%d')

    @catalogue2 = create(:catalogue, besku: @catalogue.besku, seller: @seller)
    @order2 = create(:shopping_cart_order, customer: @customer, order_status: @order_status_ordered)
    @order_item2 = create(:shopping_cart_order_item, catalogue: @catalogue2, order: @order2, quantity: 1, price: 100.0)
    @order2.order_items << @order_item2
  end
  

  let(:valid_attributes) do
    {
      token: @token,
      start_date: Date.today,
      end_date: Date.tomorrow,
      report_type: "sales_report"  # sales_report sales_and_traffic_report return_report compare_sales
    }
  end

  describe 'POST #sales_performance' do
    context 'with valid params' do
      it 'renders a JSON response with the sales performance sales report' do

        post :sales_performance, params: valid_attributes

        expect(response_body['results']).not_to be_empty
        expect(response_body['results'][0]['date']).to eq(@order_date)
        expect(response_body['results'][0]['ordered_product_sales']).to eq(@ordered_product_sales)
        expect(response_body['results'][0]['units_ordered']).to eq(@units_ordered)
        expect(response_body['results'][0]['total_order_item']).to eq(@total_order_item)
        expect(response_body['results'][0]['average_sales_per_order_item']).to eq(@average_sales_per_order_item)
        expect(response_body['results'][0]['average_units_per_order_item']).to eq(@average_units_per_order_item)
        expect(response_body['results'][0]['average_selling_price']).to eq(@average_selling_price)
        expect(response_body['results'][0]['order_item_sessions_total']).to eq(1) 
        expect(response_body['results'][0]['order_item_session_percentage']).to eq(100.0)
      end

      it 'renders a JSON response with the sales and traffic report' do
        valid_attributes[:report_type] = "sales_and_traffic_report"
        post :sales_performance, params: valid_attributes

        expect(response).to have_http_status(:ok)

        expect(response_body['results']).not_to be_empty
        expect(response_body['results'][0]['parent_besku']).to eq(@catalogue.besku)
        expect(response_body['results'][0]['child_besku']).to eq("N/A") 
        expect(response_body['results'][0]['title']).to eq(@catalogue.product_title)
        expect(response_body['results'][0]['sku']).to eq(@catalogue.sku)
        expect(response_body['results'][0]['sessions_total']).to eq(1) 
        expect(response_body['results'][0]['sessions_percentage']).to eq(100.0)
        expect(response_body['results'][0]['page_views_total']).to eq(@page_views_total)
        expect(response_body['results'][0]['page_views_percentage_total']).to eq(@page_views_percentage)
        expect(response_body['results'][0]['featured_offer_buy_box_per']).to eq(100.0)
        expect(response_body['results'][0]['units_ordered']).to eq(@units_ordered_by_items)
        expect(response_body['results'][0]['ordered_product_sales']).to eq(@order_item.price)
        expect(response_body['results'][0]['total_order_item']).to eq(@total_order_item)
      end

      it 'renders a JSON response with the return report' do
        valid_attributes[:report_type] = "return_report"
        post :sales_performance, params: valid_attributes


        expect(response_body['results']).not_to be_empty
        expect(response_body['results'][0]['date']).to eq(@order_date)
        expect(response_body['results'][0]['ordered_product_sales']).to eq(@ordered_product_sales) 
        expect(response_body['results'][0]['units_ordered']).to eq(@units_ordered)
        expect(response_body['results'][0]['total_order_item']).to eq(@total_order_item)
        expect(response_body['results'][0]['units_refunded']).to eq(0) 
        expect(response_body['results'][0]['refund_rate']).to eq(0)
        expect(response_body['results'][0]['feedback_received']).to eq(0)
        expect(response_body['results'][0]['negative_feedback_received']).to eq(0)
        expect(response_body['results'][0]['received_negative_feedback_rate']).to eq(0)
        expect(response_body['results'][0]['a_z_claims_granted']).to eq(0)
        expect(response_body['results'][0]['claims_amount']).to eq(0)
      end

      it 'renders a JSON response with the return report sorted by date in descending order' do

        post :sales_performance, params: valid_attributes.merge({ sort_by: 'date', sort_order: 'desc' })

        expect(response_body['results']).not_to be_empty
        expect(response_body['results'][0]['date']).to eq(@order_date)
      end

      it 'renders a JSON response with the compare_sales report' do
        valid_attributes[:report_type] = "compare_sales"
        post :sales_performance, params: valid_attributes

        expect(response_body['results']).not_to be_empty
        expect(response_body['results']['today_so_far']).to have_key('total_order_item')
        expect(response_body['results']['yesterday']).to have_key('units_ordered') 
        expect(response_body['results']['same_day_last_week']).to have_key('ordered_product_sales')
        expect(response_body['results']['same_day_last_year']).to have_key('average_units_or_order_item')
        expect(response_body['results']['percentage_change_from_yesterday']).to have_key('average_sales_or_order_item') 
        expect(response_body['results']['percentage_change_from_same_day_last_week']).to have_key('average_sales_or_order_item')
      end
    end

    context 'with missing params' do
      it 'renders a JSON error response when return type params are missing' do
        post :sales_performance, params: { token: @token }

        response_body = JSON.parse(response.body)

        expect(response_body['errors']).to eq("Report type is required")
      end

      it 'renders a JSON error response when start_date and end_date params are missing' do
        post :sales_performance, params: { token: @token, report_type: "report_type" }

        response_body = JSON.parse(response.body)

        expect(response_body['errors']).to eq("Please provide start_date and end_date")
      end

      it 'renders a JSON error response when return type params are missing' do
        post :sales_performance, params: { token: @token, report_type: "report_type", start_date: Date.today, end_date: Date.today }

        response_body = JSON.parse(response.body)

        expect(response_body['results']['error']).to eq('Invalid report type')
      end
    end
  end

  describe 'POST #sales_performance #export_sales_report' do
    before do 
      valid_attributes[:export_csv] = "true"
      @date = "Date"
      @ordered_product_sales = "Ordered Product Sales"
      @units_ordered = "Units Ordered"
      @total_order_item = "Total Order Item"
    end
    context '#export_sales_report with valid params' do
      it 'renders a csv response with the sales performance sales report' do

        post :sales_performance, params: valid_attributes

        expect(response_body['headers']).to eq([@date, @ordered_product_sales, @units_ordered, @total_order_item, "Average Sales Per Order Item", "Average Units Per Order Item", "Average Selling Price", "Order Item Sessions Total", "Order Item Session Percentage"])
      end

      it 'renders a csv response with the sales and traffic report' do
        valid_attributes[:report_type] = "sales_and_traffic_report"
        post :sales_performance, params: valid_attributes

        expect(response_body['headers']).to eq(["Parent Besku", "Child Besku", "Title", "Sku", "Sessions Total", "Sessions Percentage", "Page Views Total", "Page Views Percentage Total", "Featured Offer Buy Box Per", @units_ordered, "Units Ordered Percentage", @ordered_product_sales, @total_order_item])
      end

      it 'renders a csv response with the return report' do
        valid_attributes[:report_type] = "return_report"
        post :sales_performance, params: valid_attributes


        expect(response_body['headers']).to eq([@date, @ordered_product_sales, @units_ordered, @total_order_item, "Units Refunded", "Refund Rate", "Feedback Received", "Negative Feedback Received", "Received Negative Feedback Rate", "A Z Claims Granted", "Claims Amount"])
      end

      it 'renders a csv response with the compare_sales report' do
        valid_attributes[:report_type] = "compare_sales"
        post :sales_performance, params: valid_attributes

        expect(response_body['headers']).to eq(["Period", @total_order_item, @units_ordered, @ordered_product_sales, "Average Units Or Order Item", "Average Sales Or Order Item"])
        expect(response_body['values']['Period']).to eq(["Today So Far", "Yesterday", "Same Day Last Week", "Same Day Last Year", "Percentage Change From Yesterday", "Percentage Change From Same Day Last Week", "Percentage Change From Same Day Last Year"])
        expect(response_body['values'][@total_order_item]).to all(be_a(Integer))
      end

      it 'renders a error response with the sales performance sales report' do
        valid_attributes[:start_date] = Date.today - 3.days
        valid_attributes[:end_date] = Date.today - 2.days

        post :sales_performance, params: valid_attributes

        expect(response_body['errors']).to eq("No report data available for export")
      end
    end
    
  end

  private

  def csv_response
    CSV.parse(response.body, headers: true)
  end

  def response_body
    JSON.parse(response.body)
  end
end

