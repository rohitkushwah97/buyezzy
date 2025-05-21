Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockAttachment::PatchAccountBlockAssociations
  )
end
