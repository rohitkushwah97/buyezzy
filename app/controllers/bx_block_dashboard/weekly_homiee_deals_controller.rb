module BxBlockDashboard
	class WeeklyHomieeDealsController < ApplicationController
		before_action :load_weekly_homiee_deal, only: [:show]

		def index
			@weekly_homiee_deals = WeeklyHomieeDeal.all

			render json: WeeklyHomieeDealSerializer.new(@weekly_homiee_deals)
		end

		def show
			render json: WeeklyHomieeDealSerializer.new(@weekly_homiee_deal)
		end

		def latest_weekly_deal
			@weekly_homiee_deal = WeeklyHomieeDeal.all.active_homiee_deals.order(created_at: :desc)&.first

			render json: WeeklyHomieeDealSerializer.new(@weekly_homiee_deal)
		end

		private

		def load_weekly_homiee_deal
			@weekly_homiee_deal = WeeklyHomieeDeal.find_by(id: params[:id])
		end

	end
end
