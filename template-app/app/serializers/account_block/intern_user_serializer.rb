module AccountBlock
  class InternUserSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:full_name, :email, :country_code, :country_flag, :phone_number, :full_phone_number, :date_of_birth, :activated, :created_at, :updated_at)

    attribute :education do |obj|
      if obj.school_education.present?
        obj.school_education&.school_name.presence || obj.school_education&.school&.name
      elsif obj.university_education.present?
        obj.university_education&.university_name.presence || obj.university_education&.university&.name
      else
        nil
      end
    end

    attribute :following_counts do |obj|
      followings =BxBlockFavourites::Follow.where(account_id: obj.id)
      followings.count
    end

    attribute :followers_counts do |obj|
      followers = BxBlockFavourites::Follow.where(follow_id: obj.id)
      followers.count
    end

    # attribute :internships do |obj, params|
    #   if params[:internship].present?
    #     rec = obj.recommendations.find_by(internship_id: params[:internship][:id])
    #     { id: params[:internship][:id], name: params[:internship][:title], match_type: rec&.match_type }
    #   end
    # end

    attribute :internships do |obj, params|
      if params[:internship].present?
        rec = obj.recommendations.find_by(internship_id: params[:internship][:id])
        join_record = BxBlockNavmenu::AccountInternship.find_by(account_id: obj.id, internship_id: params[:internship][:id])

        response = {
          id: params[:internship][:id],
          name: params[:internship][:title],
          match_type: rec&.match_type,
          status: join_record&.status
        }

        case join_record&.status
        when "offered"
          offer = BxBlockSurveys::MakeOffer.find_by(intern_user_id: obj.id, internship_id: params[:internship][:id])
          response[:offer_status] = offer&.offer_status if offer.present?
        when "interview_requested"
          request = BxBlockRequestManagement::RequestInterview.find_by(intern_user_id: obj.id, internship_id: params[:internship][:id])
          response[:request_status] = request&.status if request.present?
        else
          response[:status] = join_record&.status
        end

        response
      end
    end

    attribute :is_contacted do |obj, params|
      if params[:internship].present?
        contact = obj&.contact_interns.find_by(internship_id: params[:internship][:id]) rescue nil
        {
          "contacted": contact.present?,
          "decision": contact&.decision
        }
      end
    end

    attribute :profile do |obj|
      profile = obj.profile
      profile.present? ?
      { 
        id: profile.id,
        country: { id: profile&.country&.id, name: profile&.country&.name },
        city: { id: profile.city&.id, name: profile.city&.name },
        photo: get_url(profile) 
      } : nil
    end

    private

    # def self.get_url(profile)
    #   Rails.application.routes.url_helpers.rails_blob_url(profile.photo) if profile&.photo&.attached?
    # end

    def self.get_url(profile)
      return nil unless profile&.photo&.attached?

      host = ENV["BASE_URL"] || "http://localhost:3000"
        {
          photo: Rails.application.routes.url_helpers.rails_blob_url(profile.photo, host: host),
          thumbnail: profile.respond_to?(:photo_thumbnail) && profile.photo_thumbnail&.attached? ?
            Rails.application.routes.url_helpers.rails_blob_url(profile.photo_thumbnail, host: host) :
            nil
        }
    end
  end
end