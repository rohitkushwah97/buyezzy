module BxBlockSurveys
	class MakeOffer < BuilderBase::ApplicationRecord
		self.table_name = :make_offers

        after_update :auto_reject_other_offers_if_two_accepted

		belongs_to :intern_user, class_name: 'AccountBlock::InternUser',foreign_key: 'intern_user_id'
		belongs_to :business_user, class_name: 'AccountBlock::BusinessUser',foreign_key: 'business_user_id'
		belongs_to :internship, class_name: 'BxBlockNavmenu::Internship',foreign_key: 'internship_id'

		enum offer_status: { pending: 0, accepted: 1, rejected: 2 }
		# validates :intern_user_id, uniqueness: { scope: :internship_id }
		# validates :intern_user_id, presence: true

		validates :number_of_days, presence: true,
                           numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 7 }

		validate :business_user_offer_limit, on: :create


	    private

	    def business_user_offer_limit
		  pending_offers_count = MakeOffer.where(internship_id: internship_id, offer_status: 'pending').count
		  accepted_offers_count = MakeOffer.where(internship_id: internship_id, offer_status: 'accepted').count

		  existing_offer = MakeOffer.exists?(internship_id: internship_id, intern_user_id: intern_user_id)

		  if existing_offer
		    errors.add(:intern_user_id, 'has already been offered for this internship.')
		  elsif accepted_offers_count >= 2
		    errors.add(:base, 'Cannot create a new offer as there are already two accepted offers for this internship.')
		  elsif pending_offers_count >= 2
		    errors.add(:base, 'You can only have up to two pending offers for this internship.')
		  elsif (pending_offers_count + accepted_offers_count) >= 2
		    errors.add(:base, 'Cannot create a new offer as the maximum number of offers for this internship has been reached.')
		  end
		end

		def auto_reject_other_offers_if_two_accepted
		  return unless saved_change_to_offer_status? && offer_status == "accepted"

		  accepted_offers = BxBlockSurveys::MakeOffer.where(
		    internship_id: internship_id,
		    offer_status: "accepted"
		  )

		  return unless accepted_offers.count == 2

		  accepted_account_ids = accepted_offers.pluck(:intern_user_id)

		  BxBlockSurveys::MakeOffer.where(internship_id: internship_id)
		    .where.not(intern_user_id: accepted_account_ids)
		    .update_all(offer_status: "rejected")

		  BxBlockNavmenu::AccountInternship.where(internship_id: internship_id)
		    .where.not(account_id: accepted_account_ids)
		    .update_all(status: "rejected")
		end
	end
end
