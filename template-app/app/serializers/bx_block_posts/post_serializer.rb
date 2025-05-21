module BxBlockPosts
  class PostSerializer < BuilderBase::BaseSerializer
    POST = "BxBlockPosts::Post"

    attributes *[
        :id,
        :name,
        :description,
        :body,
        :location,
        :account_id,
        :category_id,
        :sub_category_id,
        :created_at,
        :updated_at
    ]

    attribute :is_liked do |object, params|
      is_like = false
      if params.present? && params[:current_user].present?
        like = BxBlockLike::Like.where(like_by_id: params[:current_user].id, likeable_id: object.id, likeable_type: POST)
        is_like = true if like.present?
      end
      is_like
    end

    attribute :comment_counts do |object|
      comments = BxBlockComments::Comment.where(commentable_id: object.id, commentable_type: POST)
      comments = comments.count
    end

    attribute :like_counts do |object|
      likes = BxBlockLike::Like.where(likeable_id: object.id, likeable_type: POST)
      likes = likes.count
    end

    attribute :model_name do |object|
      object.class.name
    end

    attribute :images_and_videos do |object, params|
      if object.images.attached?
        object.images.map do |attachment|
          content_type = attachment.blob.content_type
          type = content_type.split('/')[0]

          thumbnail_url = if type == 'image'
            thumb = object.image_thumbnails.find do |thumb|
              thumb.filename.to_s.include?(attachment.filename.base)
            end

            if thumb.present?
              Rails.application.routes.url_helpers.rails_blob_url(thumb, only_path: true)
            else
              Rails.application.routes.url_helpers.rails_blob_url(attachment, only_path: true)
            end

          elsif type == 'video'
            thumb = object.video_thumbnails.find do |thumb|
              thumb.filename.to_s.include?(attachment.filename.base)
            end

            if thumb.present?
              Rails.application.routes.url_helpers.rails_blob_url(thumb, only_path: true)
            else
              ""
            end
          else
            ""
          end

          {
            id: attachment.id,
            url: Rails.application.routes.url_helpers.rails_blob_url(attachment, only_path: true),
            type: type,
            thumbnail_url: thumbnail_url
          }
        end
      else
        []
      end
    end

    attribute :media do |object, params|
      host = params[:host] || ""
      object.media.attached? ?
        object.media.map { |media|
          {
            id: media.id,
            url: host + Rails.application.routes.url_helpers.rails_blob_url(
              media, only_path: true,
            ),
            filename: media.blob[:filename],
            content_type: media.blob[:content_type],
          }
        } : []
    end

    attribute :created_at do |object|
      "#{time_ago_in_words(object.created_at)} ago"
    end

    attribute :account do |object|
      account = AccountBlock::Account.find_by(id: object.account_id)
      if account.type == "InternUser"
        AccountBlock::InternUserSerializer.new(account).serializable_hash
      elsif account.type == "BusinessUser"
        BxBlockProfile::CompanyDetailSerializer.new(account.company_detail).serializable_hash
      end
    end
  end
end
