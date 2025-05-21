# frozen_string_literal: true

class AddStatusToAttachment < ActiveRecord::Migration[6.0]
  def change
    add_column :attachments, :status, :integer
  end
end
