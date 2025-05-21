Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockSubscriptions::PatchAccountChatsAssociations
  )
end
