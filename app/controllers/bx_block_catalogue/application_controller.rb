module BxBlockCatalogue
  class ApplicationController < BuilderBase::ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation

    # before_action :validate_json_web_token

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_found
      render json: {"errors" => ["Record not found"]}, status: :not_found
    end

    def get_account    
      @account = AccountBlock::Account.find_by(id: @token.id)
    end

    def check_seller_user      
      return render json: { errors: [{ message: "You are not authorized to access warehouse" }] }, status: :forbidden unless @account&.user_type == 'seller'
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
