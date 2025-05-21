module BxBlockRequestManagement
  class RequestInterview < BxBlockRequestManagement::ApplicationRecord
    self.table_name = :request_interviews

    belongs_to :intern_user, class_name: 'AccountBlock::InternUser', foreign_key: 'intern_user_id'
    belongs_to :business_user, class_name: 'AccountBlock::BusinessUser', foreign_key: 'business_user_id'
    belongs_to :internship, class_name: 'BxBlockNavmenu::Internship', foreign_key: 'internship_id'

    has_one :chatbot_interview, class_name: 'BxBlockChatgpt3::ChatbotInterview', dependent: :nullify

    enum status: { pending: 0, accepted: 1, rejected: 2 }

    validates :intern_user_id, uniqueness: { scope: :internship_id, message: "already has a request for this internship" }
    validates :number_of_days, presence: true, inclusion: { in: 1..7, message: "must be between 1 and 7" }

    validate :internship_request_limit_not_exceeded, on: :create
    validate :internship_offer_limit_not_exceeded, on: :create

    private

    def internship_request_limit_not_exceeded
      if RequestInterview.where(internship_id: internship_id).count >= 3
        errors.add(:base, "Only 3 requests can be created for this internship")
      end
    end

    def internship_offer_limit_not_exceeded
		  accepted_offers_count = BxBlockSurveys::MakeOffer.where(internship_id: internship_id, offer_status: "accepted").count

		  if accepted_offers_count >= 2
		    errors.add(:base, "Interview request not allowed as 2 offers have already been accepted for this internship")
		  end
		end
  end
end