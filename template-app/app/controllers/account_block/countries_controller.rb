module AccountBlock
  class CountriesController < ApplicationController
    skip_before_action :validate_json_web_token, :authenticate_account
    
    def index
      res = CountrySerializer.new(Country.all).serializable_hash
      render json: res, status: status
    end

    def show
      begin
        country = Country.find(params[:id])
        res = CitySerializer.new(country.cities).serializable_hash
        render json: res, status: status
      rescue ActiveRecord::RecordNotFound
        return item_not_found('country', params[:id])
      end
    end

  end
end
