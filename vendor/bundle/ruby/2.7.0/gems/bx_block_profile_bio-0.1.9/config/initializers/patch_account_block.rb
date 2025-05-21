# frozen_string_literal: true

ActiveSupport.on_load(:account) do
  AccountBlock::Account.include(
    BxBlockProfileBio::PatchAccountBlock
  )
end
