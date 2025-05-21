module BxBlockNavmenu
  class ApplyedInternshipSerializer < BuilderBase::BaseSerializer
    attributes :id, :start_date, :end_date, :title, :description, :monthly_salary, :status, :business_user_id,
    :created_at, :updated_at, :country_id, :city_id,:industry_id,:role_id,:work_location_id,:work_schedule_id

    attribute :industry_name do |object|
      object.industry&.name
    end

    attribute :role_name do |object|
      object.role&.name
    end

    attribute :duration do |object|
      distance_of_time_in_words(object.end_date,object.start_date)
    end

    attribute :work_location do |object|
      work_location = object.work_location
      {
        name: work_location.name,
        icon: get_url(work_location.icon)
      }
    end

    attribute :work_schedule do |object|
      work_schedule = object.work_schedule
      {
        schedule: work_schedule.schedule,
        icon: get_url(work_schedule.icon)
      }
    end

    attribute :country_name do |object|
      object.country&.name
    end
 
    attribute :city_name do |object|
      object.city&.name
    end

    attribute :educational_statuses do |object|
      BxBlockProfile::EducationalStatus.where(id: object.educational_statuses)
    end

    attribute :quiz_status do |object|
      object&.user_survey&.quiz_status
    end

    attribute :retake do |object|
      object&.user_survey&.retake if object.status == "draft"
    end

    attribute :company_name do |object|
      object.business_user.company_detail.company_name rescue nil
    end

    attribute :applied do |object, params|
      app = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:id], internship_id: object.id)
      app.present? && !app.is_withdraw
    end

    attribute :is_withdraw do |object, params|
      app = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:id], internship_id: object.id)
      app&.is_withdraw
    end

    attribute :is_terminate do |object, params|
      app = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:id], internship_id: object.id)
      app&.is_terminate
    end

    attribute :is_rejected do |object, params|
      app = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:id], internship_id: object.id)
      app&.rejected?
    end

    attribute :match_type do |object,params|
      object.recommendations.find_by(bx_block_recommendation_recommendations:{ intern_user_id: params[:id]}).match_type rescue nil
    end

    attribute :followers do |object|
      followers_count = BxBlockFavourites::Follow.where(follow_id: object.business_user_id).count
      followers_count
    end

    attribute :followings do |object|
      followings_count = BxBlockFavourites::Follow.where(account_id: object.business_user_id).count
      followings_count
    end

    attribute :is_contacted do |object,params|
      contact = object.contact_interns.find_by(intern_user_id: params[:id]) rescue nil
      {
        "contacted": contact.present?,
        "decision": contact&.decision
      }
    end

    attribute :business_user_generic_question_and_answers do |object|
      object.business_user_generic_answers.map do |answer|
        {
          id: answer.id,
          question: BxBlockSurveys::BusinessUserGenericQuestionSerializer.new(answer.business_user_generic_question),
          answer: answer.answer
        }
      end
    end

    attribute :company_photo do |obj|
      photo = obj.business_user.company_detail.photo
      {
        photo: get_url(photo)
      }
    end

    attribute :application_info do |obj, params|
      return nil unless params[:current_user_id].present?

      join_record = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:current_user_id], internship_id: obj.id)

      return nil unless join_record.present?

      response = {
        application_status: join_record.status
      }

      case join_record.status
      when "offered"
        offer = BxBlockSurveys::MakeOffer.find_by(intern_user_id: params[:current_user_id], internship_id: obj.id)
        response[:offer_status] = offer&.offer_status if offer.present?
      when "interview_requested"
        request = BxBlockRequestManagement::RequestInterview.find_by(intern_user_id: params[:current_user_id], internship_id: obj.id)
        response[:request_status] = request&.status if request.present?
      else
      	response[:status] = nil
      end

      response
    end

    private

    def self.get_url(photo)
      Rails.application.routes.url_helpers.rails_blob_url(photo) if photo.attached? && Rails.env.production?
    end
  end
end
