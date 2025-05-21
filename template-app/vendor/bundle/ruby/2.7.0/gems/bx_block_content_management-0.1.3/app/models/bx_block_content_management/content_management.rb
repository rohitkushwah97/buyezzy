module BxBlockContentManagement
  class ContentManagement < ApplicationRecord
    self.table_name = :bx_block_content_management_content_managments
    has_many_attached :images
    enum user_type: { user_1: 1, user_2: 2 }
    scope :published, -> {where("publish_date < ?", DateTime.current)}
  end
end
