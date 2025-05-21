# frozen_string_literal: true

module BxBlockOrderManagement
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :validate_json_web_token
    before_action :get_user

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render json: {"errors" => ["Record not found"]}, status: :not_found
    end

    def get_user
      @current_user = AccountBlock::Account.find(@token.id)
    end

    def format_activerecord_errors(errors)
      result = []
      errors.each do |attribute, error|
        attribute_name = attribute.to_s.gsub('_', ' ')
        result << "#{attribute_name.capitalize} #{error}"
      end
      result
    end
  end
end
# rubocop:enable Naming/AccessorMethodName
