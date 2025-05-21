module BxBlockJoblisting
  class FeedSerializer < BuilderBase::BaseSerializer
    attributes(:profile_id, :published, :company_page_id, :description, :posts, :image_or_videos_url)

    attribute :posts do |object, params|
      host = params[:host] || ''
      if object.posts.attached?
        object.posts.map do |image|
          {
            id: object.id,
            url: host + Rails.application.routes.url_helpers.rails_blob_url(
              image, only_path: true
            )
          }
        end
      end
    end
  end
end
