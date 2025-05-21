require 'rails_helper'

RSpec.describe BxBlockChat::PromptManager, type: :model do
  describe 'associations' do
    it { should have_many(:prompt_versions).class_name('BxBlockChat::PromptVersion').dependent(:destroy) }
  end
end
