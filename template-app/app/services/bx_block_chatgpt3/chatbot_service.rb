require 'openai'

module BxBlockChatgpt3
  class ChatbotService
    def initialize(intern_user, prompt_version, request_interview = nil)
      @intern_user = intern_user
      @prompt_version = prompt_version
      @request_interview = request_interview
      @client = OpenAI::Client.new(api_key: ENV['OPENAI_API_KEY']) 
    end

    def start_interview
      ChatbotInterview.create!(
        intern_user: @intern_user,
        prompt_version: @prompt_version,
        request_interview: @request_interview, # 🔄 stores the link
        start_time: Time.current,
        status: 'ongoing'
      )
    end

    def ask_next_question(interview)
      messages = []

      messages << {
        role: "system",
        content: "You're a technical interviewer. Conduct an interview for this profile: #{@prompt_version.description}."
      }

      interview.chatbot_responses.order(:created_at).each do |r|
        messages << { role: "assistant", content: r.question } if r.asked_by == "system"
        messages << { role: "user", content: r.answer } if r.asked_by == "intern"
      end

      response = @client.chat(
        parameters: {
          model: "gpt-4",
          messages: messages + [{ role: "assistant", content: "Ask the next interview question." }],
          temperature: 0.7
        }
      )
      question = response.dig("choices", 0, "message", "content")

      interview.chatbot_responses.create!(
        question: question,
        asked_by: "system"
      )

      question
    end

    def submit_answer(interview, answer)
      last_question = interview.chatbot_responses.where(asked_by: 'system').last

      interview.chatbot_responses.create!(
        question: last_question&.question,
        answer: answer,
        asked_by: "intern"
      )
    end

    def terminate_interview(interview, reason)
      interview.update!(
        status: 'terminated',
        termination_reason: reason,
        end_time: Time.current
      )
    end

    def evaluate_final_decision(interview)
      messages = []

      messages << {
        role: "system",
        content: "You are a senior interviewer. Based on the following conversation, decide if the candidate is selected or rejected for the profile: #{@prompt_version.description}. Just return one word: Selected or Rejected."
      }

      interview.chatbot_responses.order(:created_at).each do |r|
        messages << { role: "assistant", content: r.question } if r.asked_by == "system"
        messages << { role: "user", content: r.answer } if r.asked_by == "intern"
      end

      result = @client.chat(
        parameters: {
          model: "gpt-4",
          messages: messages,
          temperature: 0.5
        }
      )

      decision = result.dig("choices", 0, "message", "content").strip

      interview.update!(
        termination_reason: "AI Decision: #{decision}",
        status: 'completed',
        end_time: Time.current
      )

      # Optional: Mark request as accepted if selected
      if interview.request_interview && decision.downcase == "selected"
        interview.request_interview.update(status: :accepted)
      elsif interview.request_interview && decision.downcase == "rejected"
        interview.request_interview.update(status: :rejected)
      end

      decision
    end
  end
end
