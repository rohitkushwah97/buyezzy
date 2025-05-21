module BxBlockAddfriends
  class ConnectionSerializer < BuilderBase::BaseSerializer
    attributes(:id, :account_id, :receipient_id, :status, :created_at, :updated_at)

    # attribute :current_user_detail do | object |
    #   BxBlockProfile::ProfileSerializer.new(BxBlockProfile::Profile.where(account_id: object.account_id))
    # end

    attributes :other_user_detail do | object, params |
      serialization_options = { params: params }

      BxBlockProfile::ProfileSerializer.new(BxBlockProfile::Profile.where(account_id: object.account.id), serialization_options).serializable_hash rescue nil
    end

    attribute :photo do |object, params|
      host = params[:host] || ''
      if object&.account&.profiles&.first&.photo&.attached?
        url = host + Rails.application.routes.url_helpers.rails_blob_url(
          object&.account&.profiles&.first&.photo, only_path: true )
      end
    end

  end
end
