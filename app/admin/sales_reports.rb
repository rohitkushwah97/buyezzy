ActiveAdmin.register_page "Sales Report" do
  menu priority: 1, label: "Sales Report"
  menu if: proc { false }

  content title: "Sales Performance Report" do
    panel "Generate Sales Report" do
      render partial: '/admin/bx_block_salesreporting/sales_report_form' 
    end

    div id: 'report-results' do
    end
  end

  page_action :generate_report, method: :post do
    period = params[:period]
    report_type = params[:report_type]
    category_id = params[:category_id]

    case period
    when 'daily'
      start_date = Date.today.beginning_of_day
      end_date = Date.today.end_of_day
    else
      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date
    end

    report_service = BxBlockSalesreporting::SalesReportService.new(start_date, end_date, report_type, category_id)
    report = report_service.call

    respond_to do |format|
      format.html do
        render json: report
      end
      format.json do
        send_data report.to_json, filename: "sales_report_#{Time.now.to_i}.json"
      end
      format.xml do
        send_data report.to_xml, filename: "sales_report_#{Time.now.to_i}.xml"
      end
    end
  end

  # action_item :download_report, only: :index do
  #   link_to 'Download as JSON', admin_sales_report_generate_report_path(format: :json), method: :post
  # end

  # action_item :download_report, only: :index do
  #   link_to 'Download as XML', admin_sales_report_generate_report_path(format: :xml), method: :post
  # end
end
