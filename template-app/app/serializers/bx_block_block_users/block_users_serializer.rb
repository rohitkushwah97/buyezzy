module BxBlockBlockUsers
  class BlockUsersSerializer < BuilderBase::BaseSerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
      :current_user_id,
      :account_id,
      :created_at,
      :updated_at
    ]

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
