# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Naming/VariableNumber
FactoryBot.define do
  factory :profile_bio, class: 'BxBlockProfileBio::ProfileBio' do
    height { '5.5' }
    weight { '50' }
    height_type { 'foot' }
    weight_type { 'kg' }
    body_type { 'Athletic' }
    mother_tougue { 'Hindi' }
    religion { 'Jain' }
    zodiac { 'Taurus' }
    marital_status { 'Married' }
    smoking { 'No' }
    drinking { 'No' }
    # looking_for {"Marriage"}
    about_me { 'test' }
    about_business { 'test' }
    personality { ['test 01', 'test 02', 'test 03'] }
    interests { ['test 01', 'test 02', 'test 03'] }
    languages { %w[test01 test02 test03] }
    custom_attributes do
      {
        custom_attribute_1: 'hasdas',
        custom_attribute_2: 'abc',
        custom_attribute_3: 'def'
      }
    end
    account
  end
end
# rubocop:enable Metrics/BlockLength, Naming/VariableNumber
