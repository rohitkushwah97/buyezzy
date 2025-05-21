# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BxBlockPosts::Post, type: :model do
  describe 'associations' do
    it { should belong_to :category }
    it { should belong_to(:sub_category).optional }
    it { should belong_to :account }
    it { should have_many_attached :media }
    it { should have_many_attached :images }
  end

  describe 'validations' do
    it { should validate_presence_of :body }
  end
end
