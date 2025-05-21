module BxBlockContentflag
  class FlagComment < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_contentflag_flag_comments
    belongs_to :post, class_name: 'BxBlockPosts::Post', optional: true
    belongs_to :account, class_name: 'AccountBlock::Account', optional: true
    belongs_to :flag_category, class_name: 'BxBlockContentflag::FlagCategory',  optional: true
    belongs_to :comment, class_name: 'BxBlockComments::Comment', optional: true

    after_update :update_flag_comment

    private

    def update_flag_comment
      if self.approved == true
        self.comment.update_attribute(:actived, false)
      else
        self.comment.update_attribute(:actived, true)
      end
    end

  end
end
