module BxBlockHelpCentre
  class ContactUsController < ApplicationController
    skip_before_action :validate_json_web_token, only: [:create]
    skip_before_action :authenticate_account, only: [:create]
    def create
      @contact_us = BxBlockHelpCentre::ContactUs.new(contact_us_params)

      if @contact_us.save
        render json: { message: 'Inquiry submitted successfully.' }, status: :created
      else
        render json: { errors: @contact_us.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def contact_us_params
      params.require(:contact_us).permit(:full_name, :email, :issue_type_id, :inquiry_details)
    end
  end
end
