ActiveSupport.on_load(:account) do
  AccountBlock::Account.include(
    BxBlockLike::PatchAccountBlockAssociations
  )
end
