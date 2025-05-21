module BxBlockLikeAPost
  class LikePost < BxBlockLikeAPost::ApplicationRecord
    self.table_name = :like_posts

    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :post, class_name: 'BxBlockPosts::Post'

    def self.policy_class
      ::BxBlockLikeAPostPolicies::LikeAPostPolicy
    end
  end
end
