module BxBlockSurveys
  class MakeOffersController < ApplicationController
	before_action :validate_json_web_token, :authenticate_account
    before_action :set_offer, only: [:accept, :reject]
    before_action :authorize_user!, only: [:accept, :reject]
    before_action :check_offer_deadline, only: [:create]

    def create
      @make_offer = MakeOffer.new(make_offer_params)
      @make_offer.business_user_id = @current_user.id
      if @make_offer.save
        account_internship = BxBlockNavmenu::AccountInternship.find_by(
          internship_id: @make_offer.internship_id,
          account_id: @make_offer.intern_user_id
        )

        if account_internship.present?
          account_internship.update(status: :offered)
        end

        render json: BxBlockSurveys::MakeOffersSerializer.new(@make_offer).serializable_hash,
               status: :created
      else
        render json: ErrorSerializer.new(@make_offer).serializable_hash,
               status: :unprocessable_entity
      end
    end
    
    def accept
      if @make_offer && @make_offer.pending?
        @make_offer.update(offer_status: :accepted)
        render json: { message: 'Offer accepted successfully.' }, status: :ok
      else
        render json: { error: 'Offer cannot be accepted.' }, status: :unprocessable_entity
      end
    end

  	def reject
  	  if @make_offer && @make_offer.pending?
  	    @make_offer.update(offer_status: :rejected)
  	    render json: { message: 'Offer rejected successfully.' }, status: :ok
  	  else
  	    render json: { error: 'Offer cannot be rejected.' }, status: :unprocessable_entity
  	  end
  	end

    private

    def set_offer
	    @make_offer = BxBlockSurveys::MakeOffer.find_by(id: params[:offer_id])
  	rescue ActiveRecord::RecordNotFound
  	  render json: { error: 'Offer not found.' }, status: :not_found
  	end

  	def authorize_user!
  	  unless @make_offer&.intern_user_id == @current_user.id
  	    render json: { error: 'You are not authorized to perform this action.' }, status: :not_found
  	  end
  	end

    def make_offer_params
      params.require(:make_offer).permit(:intern_user_id, :business_user_id, :internship_id, :offer_status, :number_of_days)
    end

    def check_offer_deadline
      internship = @current_user.internships.find_by(id: params[:make_offer][:internship_id])
      if internship.present? && internship.start_date <= Date.today
        return render json: { error:  'Cannot send new offers after the start date of internship.' }
      end
    end
  end
end
