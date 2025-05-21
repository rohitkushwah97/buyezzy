module BuilderBase
  class ApplicationController < ::ApplicationController
    include JSONAPI::Deserialization
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    def not_found
      render :json => {'errors' => ['Record not found']}, :status => :not_found
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
