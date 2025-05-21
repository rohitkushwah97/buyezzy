# frozen_string_literal: true

module BxBlockProfile
  class Profile < BxBlockProfile::ApplicationRecord
    ActiveSupport.run_load_hooks(:profile, self)
    self.table_name = :profiles
    has_one_attached :photo
    has_one_attached :photo_thumbnail

    belongs_to :intern_user, class_name: "AccountBlock::InternUser", foreign_key: 'account_id'
    belongs_to :country, class_name: 'AccountBlock::Country'
    belongs_to :city, class_name: 'AccountBlock::City'
  end
end
