# frozen_string_literal: true
# Protected Area Start
# Copyright (c) 2024 Engineer.ai Corp. (d/b/a Builder.ai). All rights reserved.
#  *
# This software and related documentation are proprietary to Builder.ai.
# This software is furnished under a license agreement and/or a nondisclosure
# agreement and may be used or copied only in accordance with the terms of such
# agreements. Unauthorized copying, distribution, or other use of this software
# or its documentation is strictly prohibited.
#  *
# This software: (1) was developed at private expense and no part of it was
# developed with government funds, (2) is a trade secret of Builder.ai for all
# purposes of the Freedom of Information Act, (3) is "commercial computer
# software" subject to limited utilization as provided in the contract between
# Builder.ai and its licensees, and (4) in all respects is proprietary data
# belonging solely to Builder.ai.
#  *
# For inquiries regarding licensing, please contact: legal@builder.ai
# Protected Area End

module BxBlockAttachment
  class FileAttachment < BxBlockAttachment::ApplicationRecord
    self.table_name = :bx_block_attachment_file_attachments
    include Wisper::Publisher
    has_one_attached :attachment
    enum content_type: %i[doc jpg pdf mp3 mp4]
    validates :content_type, presence: true
    validates :attachment, presence: true
    validate :attachment_size

    private
    def attachment_size
      return unless attachment.attached?
      if attachment.blob.byte_size > MAXATTACHMENTSIZE.megabytes
        errors.add(:attachment, "size needs to be less than #{MAXATTACHMENTSIZE} MB")
      end
    end
  end
end
