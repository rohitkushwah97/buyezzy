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
# This migration comes from bx_block_attachment (originally 20201120113422)
class CreateBxBlockAttachmentFileAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_attachment_file_attachments do |t|
      t.references :account, null: false, foreign_key: true
      t.string :colour
      t.string :layout
      t.string :page_size
      t.string :scale
      t.string :print_sides
      t.integer :print_pages_from
      t.integer :print_pages_to
      t.integer :total_pages
      t.boolean :is_expired, default: false
      t.integer :total_attachment_pages
      t.string :pdf_url
      t.boolean :is_printed, default: false
      t.timestamps
    end
  end
end
