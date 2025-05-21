module BxBlockContentModeration
  class ContentSerializer < BuilderBase::BaseSerializer
     attributes(:text_content, :is_text_approved, :created_by, :updated_by, :is_image_approved)

    attributes :image do |object|
      attachment object
    end

    class << self
      def attachment(object)
        object&.image&.service_url if object&.image&.attached?
      rescue StandardError
        nil
      end
    end
  
  end
end
