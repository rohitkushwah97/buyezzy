module BxBlockDashboard
  class WeeklyHomieeDealSerializer < BuilderBase::BaseSerializer
    attributes :id, :start_time, :end_time, :status, :created_at, :updated_at

    attribute :weekly_deals do |object|
      object.weekly_deals.map do |wd|
        {
          id: wd.id,
          caption: wd.caption,
          discount_percent: wd.discount_percent,
          url: wd.url,
          bg_image: self.bg_image_url(wd),
          deal: wd.deal&.serializable_hash
        }
      end
    end

    private

    def self.bg_image_url(wd)
      if wd.bg_image.attached?
        ENV['BASE_URL'] ? (ENV['BASE_URL'] + Rails.application.routes.url_helpers.rails_blob_path(wd.bg_image, only_path: true)) : Rails.application.routes.url_helpers.rails_blob_path(wd.bg_image, only_path: true)
      end
    end
  end
end
