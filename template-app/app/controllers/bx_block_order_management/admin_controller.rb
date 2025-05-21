# frozen_string_literal: true

module BxBlockOrderManagement
  class AdminController < BxBlockOrderManagement::ApplicationController
    before_action :verify_admin_token
    before_action :validate_json_web_token, :authenticate_account

    def delivery_address_create
      da = BxBlockOrderManagement::DeliveryAddress.create(
        delivery_address_params
      )
      render json: {delivery_address: da} if da.save
    end

    def get_roles
      if params[:industry_id].present?
        @roles = BxBlockCategories::Role.where(industry_id: params[:industry_id])
      else
        @roles = BxBlockCategories::Role.all
      end
      render json: BxBlockCategories::RoleSerializer.new(@roles).serializable_hash,
          status: :ok
    end

    def get_industries
      @industries = BxBlockCategories::Industry.all
      render json: BxBlockCategories::IndustrySerializer.new(@industries).serializable_hash, status: :ok
    end

    def get_work_locations
      @work_locations = BxBlockSettings::WorkLocation.all
      render json: BxBlockSettings::WorkLocationSerializer.new(@work_locations).serializable_hash, status: :ok
    end

    def get_work_schedules
      @work_schedules = BxBlockSettings::WorkSchedule.all
      render json: BxBlockSettings::WorkScheduleSerializer.new(@work_schedules).serializable_hash, status: :ok
    end

    def get_countries
      @countries = AccountBlock::Country.all
      render json: AccountBlock::CountrySerializer.new(@countries).serializable_hash, status: :ok
    end

    def get_cities
      @cities = AccountBlock::City.all
      render json: AccountBlock::CitySerializer.new(@cities).serializable_hash, status: :ok
    end

    def type_of_interns
      @inters = BxBlockProfile::EducationalStatus.all
      render json: BxBlockProfile::EducationalStatusSerializer.new(@inters).serializable_hash, status: :ok
    end
    private

    def delivery_address_params
      params.require(:delivery_address).permit(
        :account_id, :address, :address_line_2, :address_type, :address_for,
        :name, :flat_no, :zip_code, :phone_number, :latitude, :longitude,
        :residential, :city, :state_code, :country_code, :state, :country,
        :is_default, :landmark
      )
    end
    

    def verify_admin_token
      render json: {error: "Invalid admin token"} unless request.headers[:admintoken] == ENV["ADMIN_API_TOKEN"]
    end
  end
end
