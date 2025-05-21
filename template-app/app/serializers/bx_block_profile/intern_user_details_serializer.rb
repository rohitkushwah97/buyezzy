module BxBlockProfile
  class InternUserDetailsSerializer < BuilderBase::BaseSerializer
    attributes(:id)

    attribute :profile do |object|
      profile = object.profile
      profile.present? ?
      { 
        full_name: object&.full_name,
        id: profile.id,
        country: { id: profile&.country&.id, name: profile&.country&.name },
        city: { id: profile.city&.id, name: profile.city&.name },
        photo: get_url(profile) 
      } : nil
    end

    attribute :contact_information do |object|
      { 
        email: object&.email,
        country_code: object&.country_code,
        country_flag: object&.country_flag,
        phone_number: object&.phone_number,
        full_phone_number: object&.full_phone_number,
      }
    end

    attribute :career_interest do |object|
      CareerInterestSerializer.new(object&.career_interests)
    end

    attribute :school do |object|
      SchoolEducationSerializer.new(object&.school_education)
    end

    attribute :university do |object|
      UniversityEducationSerializer.new(object&.university_education)
    end

    attribute :answers do |object,params|
      internship = BxBlockNavmenu::Internship.find_by_id(params[:internship_id])
      role_id = internship&.role_id
      career_interest = object&.career_interests.find_by_role_id(role_id)
      user_survey = object.user_surveys.find_by_role_id(role_id)
      answers = internship&.intern_user_generic_answers&.where(account_id:object.id)
      questions = internship&.intern_user_generic_questions&.ids
      status = questions&.sort == answers&.pluck(:intern_user_generic_question_id)&.sort
      [ 
        {
         name: "#{career_interest&.role&.name} - #{career_interest&.industry&.name} Quiz",
         status: user_survey&.quiz_status,
         completed_date: user_survey&.submissions&.last&.updated_at&.strftime('%d/%m/%y'),
         role_id: role_id
       },
       {
         name: "Extra Questions",
         status: status ? "completed" : "pending",
         completed_date: answers&.last&.updated_at&.strftime('%d/%m/%y'),
         is_show: questions&.size&.zero? ? false :  true
       }
     ]
    end

    attribute :is_contacted do |obj, params|
      contact = obj&.contact_interns.find_by(internship_id: params[:internship_id]) rescue nil
      {
        "contacted": contact.present?,
        "decision": contact&.decision
      }
    end

    attribute :followers do |object|
      followers_count = BxBlockFavourites::Follow.where(follow_id: object.id).count
      followers_count
    end

    attribute :followings do |object|
      followings_count = BxBlockFavourites::Follow.where(account_id: object.id).count
      followings_count
    end

    private

    def self.get_url(profile)
      Rails.application.routes.url_helpers.rails_blob_url(profile.photo) if profile&.photo&.attached?
    end
  end
end
