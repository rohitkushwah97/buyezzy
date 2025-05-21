# frozen_string_literal: true
module BxBlockAddfriends
  class Connection < BuilderBase::ApplicationRecord
    self.table_name = "bx_block_addfriends_connections"
    include PushNotification
    belongs_to :account, class_name: 'AccountBlock::Account', foreign_key: 'receipient_id',optional: true
  end
end
