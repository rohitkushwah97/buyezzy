require 'rails_helper'

RSpec.describe Admin::SalesReportController, type: :controller do
  render_views
  let(:admin_user) { create(:admin_user) }
  let(:report_data) { [{ key: 'value' }] }

  before do
    sign_in admin_user
    allow(BxBlockSalesreporting::SalesReportService).to receive(:new).and_return(double(call: report_data))
  end

   describe 'GET #index' do
    it 'renders the sales report page' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('text/html; charset=utf-8')
      expect(response.body).to include('Sales Performance Report')
    end
  end

  describe 'POST #generate_report' do
    let(:start_date) { Date.today.beginning_of_day }
    let(:end_date) { Date.today.end_of_day }

    context 'when generating a JSON report' do
      it 'daily returns the report in JSON format' do
        post :generate_report, params: { period: 'daily', report_type: 'json', category_id: 1, format: :json }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(report_data.as_json)
      end

      it 'custom returns the report in xml format' do
        post :generate_report, params: { period: 'custom', report_type: 'xml', category_id: 1, format: :xml, start_date: Date.today.beginning_of_day, end_date: Date.today.end_of_day }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/xml')
        expect(Hash.from_xml(response.body)).to eq('objects' => report_data.as_json)
      end

      it 'custom returns the report in xml format' do
        post :generate_report, params: { period: 'custom', report_type: 'xml', category_id: 1, format: :xml, start_date: Date.today.beginning_of_day, end_date: Date.today.end_of_day }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/xml')
        expect(Hash.from_xml(response.body)).to eq('objects' => report_data.as_json)
      end
    end

  end
end

