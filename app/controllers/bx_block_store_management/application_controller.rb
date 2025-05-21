module BxBlockStoreManagement
  class ApplicationController < BuilderBase::ApplicationController

    include BuilderJsonWebToken::JsonWebTokenValidation
    # before_action :validate_json_web_token

    private

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
