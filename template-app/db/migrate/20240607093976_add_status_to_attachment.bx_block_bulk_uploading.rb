# This migration comes from bx_block_bulk_uploading (originally 20220816042625)
# Protected File
# frozen_string_literal: true

class AddStatusToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :status, :integer
  end
end
