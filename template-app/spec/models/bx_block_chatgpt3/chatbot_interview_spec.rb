require 'rails_helper'

RSpec.describe BxBlockChatgpt3::ChatbotInterview, type: :model do
  describe '#last_response_time' do
    let(:intern_user) { create(:intern_user) }
    let(:prompt_version) { create(:prompt_version) }
    let(:request_interview) { create(:request_interview, intern_user: intern_user) }

    let(:chatbot_interview) { create(:chatbot_interview, intern_user: intern_user, prompt_version: prompt_version, request_interview: request_interview) }

    context 'when there are chatbot responses present currectlly' do
      let!(:response_1) { create(:chatbot_response, chatbot_interview: chatbot_interview, created_at: 1.day.ago) }
      let!(:response_2) { create(:chatbot_response, chatbot_interview: chatbot_interview, created_at: 2.hours.ago) }

      it 'returns the most recent response created_at' do
        expect(chatbot_interview.last_response_time).to eq(response_2.created_at)
      end
    end

    context 'when there are no chatbot responses present or wrong data happening' do
      it 'returns the start_time' do
        expect(chatbot_interview.last_response_time).to eq(chatbot_interview.start_time)
      end
    end
  end
end
