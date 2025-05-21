require 'rails_helper'

RSpec.describe BxBlockProfile::EducationalStatus, type: :model do

  context 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  context 'Association' do
    it { should have_many :schools }
    it { should have_many :universities }
  end
end
