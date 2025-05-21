# frozen_string_literal: true

module BxBlockContentModeration
  class Content < ApplicationRecord
    self.table_name = :bx_block_content_moderation_contents

    has_one_attached :image, dependent: :destroy
    
  end
end
