module BxBlockSalesreporting
  class ReportsController < ApplicationController
    before_action :current_seller, only: [:sales_performance]

    def sales_performance
      return render json: {errors: "Report type is required"}, status: :bad_request if params[:report_type].blank?

      report_type = params[:report_type]
      seller = @current_seller
      page = params[:page].to_i > 0 ? params[:page].to_i : 1
      per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10

      sort_by = params[:sort_by]
      sort_order = params[:sort_order] || 'asc'

      if report_type == 'compare_sales'
        report = SalesReportService.new(nil, nil, report_type, seller).call
      else
        report = fetch_sales_report_with_dates(report_type, seller, sort_by, sort_order)
        return if performed?
      end

      if params[:export_csv]&.to_s == 'true'
        return export_sales_report(report, report_type) unless report.empty?
        return render json: { errors: "No report data available for export" }, status: :unprocessable_entity
      end

      total_count = report.count
      report = paginate_array(report, page, per_page)

      render json: { results: report, total_count: total_count}, status: :ok
    end

    def fetch_sales_report_with_dates(report_type, seller, sort_by, sort_order)
      if params[:start_date].blank? || params[:end_date].blank?
        return render json: { errors: "Please provide start_date and end_date" }, status: :bad_request
      end

      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date

      report = SalesReportService.new(start_date, end_date, report_type, seller, sort_by, sort_order).call

      report
    end

    def export_sales_report(report, report_type)
      headers = if report_type == "compare_sales"
        report.values.first.keys.map { |key| key.to_s.titleize }.unshift("Period")
      else
        report.first.keys.map { |key| key.to_s.titleize }
      end

      periods = (report_type == "compare_sales" ? report.keys.map { |key| key.to_s.titleize } : [] ) 

      formatted_data = headers.each_with_object({}) do |header, hash|
        hash[header] = []
      end

      if report_type == 'compare_sales'
        formatted_data['Period'] = periods

        report.each do |period, data|
          data.each do |key, value|
            formatted_data[key.to_s.titleize] << value
          end
        end
      else
      report.each do |data_row|
        headers.each do |header|
          converted_key = header.downcase.gsub(' ','_').to_sym
          formatted_data[header] << data_row[converted_key]
        end
      end
    end

      render json: { headers: headers, values: formatted_data }
    end

    private

    def current_seller
      @current_seller = AccountBlock::Account.find_by(id: @token&.id, user_type: "seller")
     render json: {error: "Seller not found"} and return unless @current_seller
   end

   def paginate_array(array, page, per_page)
    return Kaminari.paginate_array(array)
                  .page(page).per(per_page) if array.is_a?(Array)
    
    array
  end

 end
end