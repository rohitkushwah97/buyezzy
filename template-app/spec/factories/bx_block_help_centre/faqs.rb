FactoryBot.define do
  factory :faq, class: 'BxBlockHelpCentre::Faq' do
    question { "What is Ruby on Rails?" }
    answer { "A web-application framework." }
    created_for { 'Business user' }  # Can be 'Business user' or 'Intern user'
  end
end
