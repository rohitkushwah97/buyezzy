module BxBlockLike
  class LikeSerializer < BuilderBase::BaseSerializer
    attributes :likeable_id, :likeable_type, :like_by_id, :created_at, :updated_at

    attribute :account do |obj|
      account = AccountBlock::Account.find_by(id: obj.like_by_id)
      if account.type == "InternUser"
        AccountBlock::InternUserSerializer.new(account).serializable_hash
      elsif account.type == "BusinessUser"
        BxBlockProfile::CompanyDetailSerializer.new(account.company_detail).serializable_hash
      end
    end
  end
end