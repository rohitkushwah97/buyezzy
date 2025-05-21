module BxBlockFavourites
  class Follow < BxBlockFavourites::ApplicationRecord
    self.table_name = :follows

    belongs_to :account, class_name: "AccountBlock::Account"
  end
end


