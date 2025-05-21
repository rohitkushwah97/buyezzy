FactoryBot.define do
  factory :social_platform, class: 'BxBlockSupport::SocialPlatform' do
    social_media { "MyString" }
    social_media_url { "MyString" }
    social_icon { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'Sample.jpg')) }
  end
end
