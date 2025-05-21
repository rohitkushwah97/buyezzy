module BxBlockContentflag
  class FlagCategory < BuilderBase::ApplicationRecord
    self.table_name = :bx_block_contentflag_flag_categories
    has_many :contents, class_name: 'BxBlockContentflag::Content',dependent: :destroy
    has_many :flag_comments, class_name: 'BxBlockContentflag::FlagComment', dependent: :destroy
    validates :reason, uniqueness: {message: "Reason already exists", case_sensitive: false }, presence: true
  end
end
