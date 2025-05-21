FactoryBot.define do
  factory :contact, class: 'BxBlockContactUs::Contact' do
    first_name { 'John' }
    last_name { 'Doe' }
    title { 'general feedback' }
    email { 'john.doe@example.com' }
    description { 'dummy description' }
    contact_type { 'feedback' }
    image {Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures','files', 'Sample.jpg'))}
  end

end
