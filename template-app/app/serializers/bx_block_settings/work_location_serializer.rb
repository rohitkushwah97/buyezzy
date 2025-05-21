module BxBlockSettings
    class WorkLocationSerializer
      include FastJsonapi::ObjectSerializer
  
      attributes(:id, :name, :code, :icon, :created_at, :updated_at)
  
      attribute :icon do |object|
        image_url = (ENV["BASE_URL"] || "https://theinternappfinalversion-623716-ruby.b623716.dev.eastus.az.svc.builder.cafe" || 'http://localhost:3000') + Rails.application.routes.url_helpers.rails_blob_path(object.icon, only_path: true) if object.icon.attached?
        image_url
      end
    end
  end
  