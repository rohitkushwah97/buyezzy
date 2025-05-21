module BxBlockChatgpt3
  class AutoTerminateInterviewJob < ApplicationJob
    queue_as :default

    def perform
      ChatbotInterview.where(status: 'ongoing').find_each do |interview|
        if interview.start_time < 30.minutes.ago
          ChatbotService.new(interview.intern_user, interview.prompt_version)
                        .terminate_interview(interview, "Terminated after 30 minutes")
          next
        end
        last_response = interview.chatbot_responses.order(updated_at: :desc).first
        last_activity_time = last_response&.updated_at || interview.start_time
        if last_activity_time < 5.minutes.ago
          ChatbotService.new(interview.intern_user, interview.prompt_version)
                        .terminate_interview(interview, "Terminated due to interviewer inactivity more then 5 minute")
        end
      end
    end
  end
end
