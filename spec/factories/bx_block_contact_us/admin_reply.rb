FactoryBot.define do
  factory :admin_reply, class: 'BxBlockContactUs::AdminReply' do
    description { "MyText" }
    image {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg'))}
    association :contact, factory: :contact
  end
end
