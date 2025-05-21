FactoryBot.define do
  factory :contact_intern, class: 'BxBlockSurveys::ContactIntern' do
   decision { 0 }
   association :internship
   association :intern_user
  end
end
