Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockComments::PatchAccountBlockAssociations
  )
end
