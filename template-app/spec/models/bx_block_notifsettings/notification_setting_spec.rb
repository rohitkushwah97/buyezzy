require 'rails_helper'

RSpec.describe BxBlockNotifsettings::NotificationSetting, type: :model do
  # Associations
  describe "associations" do
    it { should belong_to(:account).class_name('AccountBlock::Account') }
  end
end