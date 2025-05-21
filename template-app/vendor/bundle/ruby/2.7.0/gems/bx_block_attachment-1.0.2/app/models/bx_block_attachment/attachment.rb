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
  class Attachment < BxBlockAttachment::ApplicationRecord
    self.table_name = :attachments
    include Wisper::Publisher

    has_one_attached :attachment
    belongs_to :account, class_name: 'AccountBlock::Account'
    after_create :default_values
    scope :not_expired, -> {where('is_expired = ?',false)}

    def default_values
      self.colour = "Greyscale"
      self.layout = "Portrait"
      self.page_size = "A4"
      self.print_sides = "Both"
      self.scale = "Print all pages"
      self.print_pages_from = 1
      self.print_pages_to = 1
      self.total_pages = 1
    end

    def self.attachment_expire
      attachments = BxBlockAttachment::Attachment.where(
        "created_at + '4 hours'::interval < ? AND is_expired =?", DateTime.now, false
      )
      if attachments.present?
        attachments.each do |attachment|
          broadcast(:attachment_expired, attachment)
          attachment.update_attributes(:is_expired => true)
          if attachment.attachment.attached?
            attachment.attachment.purge
            attachment.destroy
          end
        end
      end

      expired_attachments = BxBlockAttachment::Attachment.where(
        "created_at + '4 hours'::interval < ? AND is_expired =?", DateTime.now, true
      )
      if expired_attachments.present?
        expired_attachments.each do |at|
          at.destroy
        end
      end
    end
  end
end
