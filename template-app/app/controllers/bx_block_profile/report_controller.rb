module BxBlockProfile
  class ReportController < ApplicationController
    before_action :validate_json_web_token
    before_action :authenticate_account
    before_action :set_report, only: [:show, :update, :destroy]

    def index
      reports = BxBlockProfile::Report.all.order(created_at: :desc)
      render_with_report_serializer(reports)
    end

    def create
      created_for = AccountBlock::Account.find_by(id: params[:created_for_id])
      internship = BxBlockNavmenu::Internship.find_by(id: params[:internship_id] )
      if created_for || internship
        @report = BxBlockProfile::Report.new(report_params.except(:created_for_id,:internship_id))
        @report.created_for = created_for if created_for
        @report.internship = internship if internship
        @report.created_by = @current_user
        if @report.save
          render_with_report_serializer(@report, :created)
        else
          render json: { errors: @report.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: ['Account or Internship not found with given ID'] }, status: :unprocessable_entity
      end
    end

    def show
      render_with_report_serializer(@report)
    end

    def destroy
      if @report.destroy
        render json: { message: 'Report deleted successfully' }, status: :ok
      else
        render json: { errors: @report.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def render_with_report_serializer(object, status = :ok)
      res = BxBlockProfile::ReportSerializer.new(object).serializable_hash
      render json: res, status: status
    end

    def set_report
      @report = BxBlockProfile::Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :description, :created_for_id)
    end
  end
end
