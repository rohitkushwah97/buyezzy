module BxBlockProfile
  class CompanyDetailsController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token
    before_action :authenticate_account
    before_action :find_business_user

    def show
      company_detail = @current_user.company_detail
      render json: BxBlockProfile::CompanyDetailSerializer.new(company_detail).serializable_hash
    end

    def update
      company_detail = @current_user.company_detail
      if company_detail.update(company_detail_params)
        render json: { message: "Profile updated successfully", data: company_detail }, status: :ok
      else
        render json: { errors: company_detail.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def intern_user_profile_details
      intern_user = AccountBlock::InternUser.find_by_id(params[:intern_user_id])
      data = BxBlockProfile::InternUserDetailsSerializer.new(intern_user,{params:{internship_id: params[:internship_id]}}).serializable_hash
      render json: data, status: 200
    end

    private

    def company_detail_params
      params.require(:company_detail).permit(
        :company_name, :industry_id, :website_link, :contact_number, :country_code, :phone_number,
        :country_id, :city_id, :address, :company_description, :country_flag
      )
    end

    def find_business_user
      return render json: {error: 'invalid user, account should be business account' } unless @current_user.type == 'BusinessUser'
    end
  end
end