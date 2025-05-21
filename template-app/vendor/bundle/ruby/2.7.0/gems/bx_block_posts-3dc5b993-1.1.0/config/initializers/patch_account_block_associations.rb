ActiveSupport.on_load(:account) do
  AccountBlock::Account.include(
    BxBlockPosts::PatchAccountBlockAssociations
  )
end
