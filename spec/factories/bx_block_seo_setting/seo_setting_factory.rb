FactoryBot.define do
  factory :seo_setting, class: 'BxBlockSeoSetting::SeoSetting' do
  	page_name {Faker::Lorem.unique.word}
  end
end