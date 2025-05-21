require 'rails_helper'

RSpec.describe BxBlockSeoSetting::SeoSetting, type: :model do
  describe 'validations' do
      subject { FactoryBot.build(:seo_setting) }

      it { should validate_presence_of(:page_name) }
      it { should validate_uniqueness_of(:page_name) }
    end
end
