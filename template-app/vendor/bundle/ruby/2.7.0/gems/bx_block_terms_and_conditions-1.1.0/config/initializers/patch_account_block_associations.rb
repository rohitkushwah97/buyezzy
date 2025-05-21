ActiveSupport.on_load(:account) do
  AccountBlock::Account.include(
    BxBlockTermsAndConditions::PatchAccountBlockAssociations
  )
end
