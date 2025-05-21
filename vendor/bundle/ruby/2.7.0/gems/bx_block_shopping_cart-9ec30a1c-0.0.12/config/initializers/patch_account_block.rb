Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockShoppingCart::PatchAccountBlock
  )
end
