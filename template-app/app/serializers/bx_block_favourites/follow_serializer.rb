module BxBlockFavourites
  class FollowSerializer < BuilderBase::BaseSerializer
    attributes :id, :account_id, :follow_id, :created_at, :updated_at

    attribute :is_followings do |object|
       followings = BxBlockFavourites::Follow.where(account_id: object.follow_id, follow_id: object.account_id).present?
       followings
    end

    attribute :followed_user do |object|
      account = AccountBlock::Account.find_by(id: object.follow_id)
      if account.type == "InternUser"
        AccountBlock::InternUserSerializer.new(account).serializable_hash
      elsif account.type == "BusinessUser"
        BxBlockProfile::CompanyDetailSerializer.new(account.company_detail).serializable_hash
      end
    end

  end
end