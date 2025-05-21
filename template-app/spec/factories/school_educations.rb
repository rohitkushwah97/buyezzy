FactoryBot.define do
  factory :school_education, class: 'BxBlockProfile::SchoolEducation' do
    intern_user
    educational_status
    school
    school_name { "school name" }
    academic_level
    academic_achievement { "topped in JEE" }
    extracurricular_activity { "sleep" }
    soft_skill { "public speaking" }
    interest { "tech, writing" }
    hobby { "cricket, music" }
  end
end
