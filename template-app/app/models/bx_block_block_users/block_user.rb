module BxBlockBlockUsers
  class BlockUser < BxBlockBlockUsers::ApplicationRecord
    self.table_name = :block_users
    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :current_user, class_name: 'AccountBlock::Account'

    after_create :unfollow_blocked_users
    after_create :blocked_users

    def unfollow_blocked_users
      BxBlockFavourites::Follow.find_by(account_id: current_user.id,follow_id: self.account_id)&.destroy
    end

    def blocked_users
      BxBlockBlockUsers::BlockUserService.new(account, current_user).block_user
    end
  end
end
