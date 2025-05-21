# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockContactUs::Contact, type: :model do
  # describe 'should have has_many association' do
  #   it { should have_many(:admin_replies).class_name('BxBlockContactUs::AdminReply').dependent(:destroy) }
  # end

  describe 'nested attributes' do
    it do
      should accept_nested_attributes_for(:admin_replies).
        allow_destroy(true)
    end
  end

  describe 'validation' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:contact_type) }
  end
  
  describe 'has_one_attached' do
    it { should have_one_attached(:image) }
  end

  describe 'enum' do
    it do
      should define_enum_for(:contact_type).
        with_values(
          complaint: "complaint",
          feedback: "feedback",
          query: "query"
        ).
        backed_by_column_of_type(:string)
    end
  end
end
