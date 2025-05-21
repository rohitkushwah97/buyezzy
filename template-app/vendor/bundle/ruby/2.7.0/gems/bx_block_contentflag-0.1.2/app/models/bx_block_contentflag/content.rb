module BxBlockContentflag
  class Content < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_contentflag_contents
      belongs_to :post, class_name: 'BxBlockPosts::Post', optional: true
      belongs_to :account, class_name: 'AccountBlock::Account', optional: true
      belongs_to :flag_category, class_name: "BxBlockContentflag::FlagCategory", optional: true

      after_update :update_flag_post

    private

    def update_flag_post
      if self.approved == true
        self.post.update_attribute(:activated, false)
      else
        self.post.update_attribute(:activated, true)
      end
    end
  end
end