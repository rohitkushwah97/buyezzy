FactoryBot.define do
  factory :career_interest, class: 'BxBlockProfile::CareerInterest' do
    intern_user
    industry
    role
    update_count { 0 }
  end
end