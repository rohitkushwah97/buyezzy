# frozen_string_literal: true

module BxBlockNavmenu
  class AccountInternship < ApplicationRecord
    self.table_name = "accounts_bx_block_navmenu_internships"

    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :internship, class_name: 'BxBlockNavmenu::Internship'

    enum status: { pending: "pending", offered: "offered", rejected: "rejected", interview_requested: "interview_requested" }

    validates :status, presence: true

    # Show ID first in API response
    def as_json(options = {})
      {
        id: id,
        account_id: account_id,
        internship_id: internship_id,
        status: status,
        created_at: created_at,
        updated_at: updated_at
      }
    end

    # Show ID first in console output
    def inspect
      "#<#{self.class.name} id: #{id}, account_id: #{account_id}, internship_id: #{internship_id}, status: #{status}, created_at: #{created_at}, updated_at: #{updated_at}>"
    end
  end
end
