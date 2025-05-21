# Protected File
# frozen_string_literal: true

class AddFilesToAttachments < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :files, :string
  end
end
