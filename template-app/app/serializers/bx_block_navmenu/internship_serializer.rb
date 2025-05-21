module BxBlockNavmenu
  class InternshipSerializer < BuilderBase::BaseSerializer
    attributes :id, :start_date, :end_date, :deadline_date, :title, :description, :monthly_salary, :status, :business_user_id,
    :created_at, :updated_at, :country_id, :city_id,:industry_id,:role_id,:work_location_id,:work_schedule_id

    attribute :industry_name do |object|
      object.industry&.name
    end

    attribute :deadline_date do |object|
      object.deadline_date&.strftime("%d-%m-%Y")
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
      app.present? ? app&.is_withdraw : false
    end

    attribute :is_closed

    attribute :is_terminate do |object, params|
      app = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:id], internship_id: object.id)
      app.present? ? app&.is_terminate : false
    end

    attribute :is_rejected do |object, params|
      app = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:id], internship_id: object.id)
      app.present? ? app&.rejected? : false
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
      host = ENV["BASE_URL"] || "http://localhost:3000"
      photo = obj.business_user.company_detail.photo
      thumbnail = obj.business_user.company_detail.photo_thumbnail
      {
        photo: photo&.attached? ? host + Rails.application.routes.url_helpers.rails_blob_url(photo, only_path: true) : nil,
        thumbnail: thumbnail&.attached? ? host + Rails.application.routes.url_helpers.rails_blob_url(thumbnail, only_path: true) : nil
      }
    end

    attribute :application_status do |object, params|
      app = BxBlockNavmenu::AccountInternship.find_by(account_id: params[:id], internship_id: object.id)

      if app.nil?
        nil
      else
        status_info = { status: app.status }

        case app.status
        when "offered"
          offer = BxBlockSurveys::MakeOffer.find_by(intern_user_id: params[:id], internship_id: object.id)
          status_info[:offer_status] = offer&.offer_status || "pending"
          status_info[:offer_id] = offer&.id
          status_info[:number_of_days] = offer&.number_of_days
        when "interview_requested"
          interview = BxBlockRequestManagement::RequestInterview.find_by(intern_user_id: params[:id], internship_id: object.id)
          status_info[:interview_status] = interview&.status || "pending"
          status_info[:interview_id] = interview&.id
          status_info[:number_of_days] = interview&.number_of_days
        else
          status_info
        end
        status_info
      end
    end

    private

    def self.get_url(photo)
      Rails.application.routes.url_helpers.rails_blob_url(photo) if photo.attached? && Rails.env.production?
    end
  end
end
