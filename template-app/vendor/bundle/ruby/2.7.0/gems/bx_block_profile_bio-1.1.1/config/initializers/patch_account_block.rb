# frozen_string_literal: true

# patch account block
ActiveSupport.on_load(:account) do
  AccountBlock::Account.include(
    BxBlockProfileBio::PatchAccountBlock
  )
end
