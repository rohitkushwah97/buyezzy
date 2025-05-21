# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockProfileBio::ProfileBio, type: :model do
  let(:category) { BxBlockCategories::Category.create!(name: Faker::Alphanumeric.unique.alphanumeric(number: 7)) }

  let(:account) do
    AccountBlock::Account.create!(email: "tester@me.com", password: "pAssword!23", password_confirmation: "pAssword!23",
                                  first_name: "test", last_name: "test", activated: true)
  end

  let(:profile_bio) do
    BxBlockProfileBio::ProfileBio.create!(height: '5.5', weight: '50', height_type: 'foot',weight_type: 'kg',
                                          body_type: 'Athletic', mother_tougue: 'Hindi', religion: 'Jain',
                                          zodiac: 'Taurus', marital_status: 'Married', smoking: 'No', drinking: 'No',
                                          looking_for: 'Marriage', about_me: 'test', about_business: 'test',
                                          personality: ['Extrovert'], interests: ['Astronomy'],
                                          languages: %w[test01 test02 test03], account_id: account.id)
  end

  let(:preference) do
    BxBlockProfileBio::Preference.create!(seeking: 'Female', discover_people: 'random', location: 'test',
                                          distance: '50', height_type: 'foot', friend: true, business: true,
                                          match_making: true, travel_partner: true, cross_path: true,
                                          age_range_start: 27, age_range_end: 32, height_range_start: 5,
                                          height_range_end: 6, account_id: account.id, profile_bio_id: profile_bio.id)
  end

  describe 'associations' do
    it { should have_many(:careers) }
  end

  describe 'enum' do
    it {
      should define_enum_for(:marital_status).with_values(%i[Single In-Relationship Engaged Married Divorced
                                                             Widowed]).with_prefix(:marital_status)
    }
    it { should define_enum_for(:smoking).with_values(%i[Yes No Sometimes]).with_prefix(:smoking) }
    it { should define_enum_for(:height_type).with_values(%i[cm inches foot]).with_prefix(:height_type) }
    it { should define_enum_for(:body_type).with_values(%i[Athletic Average Fat Slim]).with_prefix(:body_type) }
  end
end
