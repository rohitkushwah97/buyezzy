require 'rails_helper'

RSpec.describe BxBlockContactUs::AdminReply, type: :model do
    describe 'associations' do
    it { should belong_to(:contact).class_name('BxBlockContactUs::Contact') }
    it { should have_one_attached(:image) }
    end

    describe 'validations' do
      it { should validate_presence_of(:description) }
    end
end
