# frozen_string_literal: true

module BxBlockShare
  # share serializer
  class ShareSerializer < BuilderBase::BaseSerializer
    attributes :id, :account_id, :shared_to_id, :post_id, :created_at, :updated_at

    attribute :documents do |object, params|
      if object.documents.attached?
        object.documents.map do |doc|
          {
            id: doc.id, filename: doc.filename,
            url: params[:host] + Rails.application.routes.url_helpers.rails_blob_path(doc, only_path: true),
            type: doc.blob.content_type.split("/")[0]
          }
        end
      else
        []
      end
    end
  end
end
