require 'rails_helper'

RSpec.describe Threshold, type: :model do
  subject { described_class.new(threshold_percentage: 50) }

  describe 'validations' do
    it 'is invalid without a threshold_percentage' do
      subject.threshold_percentage = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:threshold_percentage]).to include("can't be blank")
    end

    it 'is invalid with a threshold_percentage equal to -1' do
      subject.threshold_percentage = -1
      expect(subject).to_not be_valid
      expect(subject.errors[:threshold_percentage]).to include("is not included in the list")
    end

    it 'is invalid with a threshold_percentage greater than 100' do
      subject.threshold_percentage = 101
      expect(subject).to_not be_valid
      expect(subject.errors[:threshold_percentage]).to include("is not included in the list")
    end
  end
end
