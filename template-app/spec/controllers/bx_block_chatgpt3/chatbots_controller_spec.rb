require 'rails_helper'
RSpec.describe BxBlockChatgpt3::ChatbotsController, type: :controller do
  let!(:intern_user) { create(:intern_user, activated: true) }
  let!(:prompt_version) { create(:prompt_version) }
  let!(:request_interview) { create(:request_interview, intern_user: intern_user, status: :pending) }

  let(:token) { BuilderJsonWebToken::JsonWebToken.encode(intern_user.id) }

  before do
    request.headers.merge!(token: token)
    @request.env['CONTENT_TYPE'] = 'application/json'
    allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({
      "choices" => [{ "message" => { "content" => "What is your experience with AI?" } }]
    })
    allow_any_instance_of(BxBlockChatgpt3::ChatbotInterview).to receive(:chatbot_responses).and_wrap_original do |original, *args|
      relation = original.call(*args)
      allow(relation).to receive(:create!).and_return(
        double("ChatbotResponse", question: "Mocked", answer: "Mocked", asked_by: "system", prompt_index: 0, created_at: Time.current)
      )
      relation
    end
  end

  describe 'POST #start_interview' do
    context 'when valid' do
      it 'starts the interview and returns the first question' do
        post :start_interview, params: {
          intern_user_id: intern_user.id,
          internship_id: request_interview.internship_id
        }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq("Interview started")
        expect(json['interview_id']).not_to be_nil
        expect(json['question']).to eq("What is your experience with AI?")
      end
    end

    context "when intern user is not found" do
      it "returns 404" do
        allow(AccountBlock::InternUser).to receive(:find).and_raise(ActiveRecord::RecordNotFound)
        post :start_interview, params: { intern_user_id: -1 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq({ "error" => "Intern user not found" })
      end
    end

    context "when no pending interview request" do
      it "returns 403 forbidden" do
        allow(AccountBlock::InternUser).to receive(:find).and_return(intern_user)
        allow(BxBlockRequestManagement::RequestInterview).to receive(:find_by).and_return(nil)
        post :start_interview, params: { intern_user_id: intern_user.id }
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)).to eq({ "error" => "No interview request found or already processed" })
      end
    end
  end

  describe 'POST #submit_response' do
    let!(:chatbot_interview) {
      BxBlockChatgpt3::ChatbotService.new(intern_user, prompt_version, request_interview).start_interview
    }

    def create_responses(count:)
      count.times do |i|
        create(:chatbot_response, chatbot_interview: chatbot_interview, asked_by: 'system', question: "System Q#{i}", answer: "dummy", prompt_index: i)
        create(:chatbot_response, chatbot_interview: chatbot_interview, asked_by: 'intern', question: "System Q#{i}", answer: "A#{i}", prompt_index: i)
      end
    end

    context 'when interview is ongoing (less than 5 system questions)' do
      before do
        create_responses(count: 2)
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({
          "choices" => [{ "message" => { "content" => "What is your next challenge?" } }]
        })
      end

      it 'returns the next question' do
        post :submit_response, params: {
          intern_user_id: intern_user.id,
          interview_id: chatbot_interview.id,
          answer: "Here's my answer"
        }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq("Answer recorded")
        expect(json['next_question']).to eq("What is your next challenge?")
      end
    end

    context 'when 5 or more system questions already asked' do
      before do
        create_responses(count: 5)
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({
          "choices" => [{ "message" => { "content" => "Selected" } }]
        })
      end

      it 'completes the interview and returns decision' do
        post :submit_response, params: {
          intern_user_id: intern_user.id,
          interview_id: chatbot_interview.id,
          answer: "Final answer"
        }
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json['message']).to eq("Interview complete")
        expect(json['decision']).to eq("Selected")
      end
    end
  end
end
