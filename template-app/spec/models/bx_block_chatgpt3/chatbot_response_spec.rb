require 'rails_helper'

RSpec.describe BxBlockChatgpt3::ChatbotResponse, type: :model do

  describe 'Assosiation for chatbot interview' do
    it { should belong_to(:chatbot_interview).class_name('BxBlockChatgpt3::ChatbotInterview') }
  end
end
