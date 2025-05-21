ActiveSupport.on_load(:account) do
  AccountBlock::Account.include(
    BxBlockPushNotifications::PatchAccountBlockAssociations
  )
end
