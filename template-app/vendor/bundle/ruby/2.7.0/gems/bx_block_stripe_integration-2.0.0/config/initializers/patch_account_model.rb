ActiveSupport.on_load(:account) do
  AccountBlock::Account.include BxBlockStripeIntegration::PatchAccountBlockAssociations
end
