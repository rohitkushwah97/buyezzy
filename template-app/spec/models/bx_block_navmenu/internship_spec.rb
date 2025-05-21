require 'rails_helper'

RSpec.describe BxBlockNavmenu::Internship, type: :model do
  # Associations
  it { should belong_to(:industry).class_name('BxBlockCategories::Industry').with_foreign_key('industry_id') }
  it { should belong_to(:role).class_name('BxBlockCategories::Role').with_foreign_key('role_id') }
  it { should belong_to(:work_location).class_name('BxBlockSettings::WorkLocation').with_foreign_key('work_location_id') }
  it { should belong_to(:work_schedule).class_name('BxBlockSettings::WorkSchedule').with_foreign_key('work_schedule_id') }
  it { should belong_to(:country).class_name('AccountBlock::Country').with_foreign_key('country_id') }
  it { should belong_to(:city).class_name('AccountBlock::City').with_foreign_key('city_id') }
  it { should belong_to(:business_user).class_name('AccountBlock::BusinessUser') }
  it { should have_many(:intern_user_generic_questions).class_name("BxBlockSurveys::InternUserGenericQuestion").dependent(:destroy) }
  it { should have_many(:intern_user_generic_answers).class_name("BxBlockSurveys::InternUserGenericAnswer").dependent(:destroy) }
  it { should have_many(:business_user_generic_answers).class_name("BxBlockSurveys::BusinessUserGenericAnswer").dependent(:destroy) }
 
  # Validations
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:deadline_date) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:monthly_salary) }
  it { should validate_numericality_of(:monthly_salary).is_greater_than_or_equal_to(0) }

end