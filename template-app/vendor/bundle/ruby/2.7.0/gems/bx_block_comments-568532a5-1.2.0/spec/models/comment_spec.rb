# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BxBlockComments::Comment, type: :model do
  describe 'associations' do
    it { should belong_to :account}
    it { should belong_to :commentable}
  end

  describe 'validations' do
    it { should validate_presence_of :comment}
  end
end
