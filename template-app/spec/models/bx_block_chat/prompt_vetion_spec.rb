require 'rails_helper'

RSpec.describe BxBlockChat::PromptVersion, type: :model do
  describe 'associations' do
    it { should belong_to(:prompt_manager).class_name('BxBlockChat::PromptManager') }
  end
end
