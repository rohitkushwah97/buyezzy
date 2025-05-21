# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockProfileBio::Preference, type: :model do
  describe 'associations' do
    it { should belong_to(:account).class_name("AccountBlock::Account") }
  end

  describe 'enum' do
    it { should define_enum_for(:religion).with_values(%i[Buddhist Christian Hindu Jain Muslim Sikh]).with_prefix(:religion)
    }
    it { should define_enum_for(:seeking).with_values(%i[Male Female Both]).with_prefix(:seeking) }
    it { should define_enum_for(:smoking).with_values(%i[Yes No Sometimes]).with_prefix(:smoking) }
    it { should define_enum_for(:drinking).with_values(%i[Yes No Occasionally]).with_prefix(:drinking) }
    it { should define_enum_for(:height_type).with_values(%i[cm inches foot]).with_prefix(:height_type) }
    it { should define_enum_for(:body_type).with_values(%i[Athletic Average Fat Slim]).with_prefix(:body_type) }
  end
end
