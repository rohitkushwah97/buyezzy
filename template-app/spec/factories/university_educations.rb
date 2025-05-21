FactoryBot.define do
  factory :university_education, class: 'BxBlockProfile::UniversityEducation' do
    intern_user
    educational_status
    university
    university_name {"vit"}
    specialisation {"b.tech"}
    graduation_year {2025}
  end
end