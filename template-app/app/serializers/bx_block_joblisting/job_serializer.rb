# frozen_string_literal: true

module BxBlockJoblisting
  # job
  class JobSerializer < BuilderBase::BaseSerializer
    attributes(:company_page_id, :job_title, :remote_job, :location, :employment_type_id, :total_inteview_rounds, :question_answer_id, :job_video,
               :job_description, :salary, :seniority_level, :job_function, :industry_id, :other_skills, :skill_id, :preffered_location, :addresses, :created_at, :sub_emplotyment_type)

    attribute :job_video do |object, params|
      host = params[:host] || ''
      if object.job_video.attached?
        url = host + Rails.application.routes.url_helpers.rails_blob_url(
          object.job_video, only_path: true
        )
      end
    end

    # attributes :industry_name do | object |
    #   BxBlockProfile::Industry.find_by(id: object&.industry_id)
    # end

    # attribute :employment_type do |object|
    #   BxBlockProfile::EmploymentType.find_by(id: object&.employment_type_id)
    # end

    # attribute :skill_name do |object|
    #   BxBlockJoblisting::Skill.where(id: object&.skill_id)
    # end

    # attribute :question_answers do |object|
    #   BxBlockJoblisting::QuestionAnswer.where(id: object&.question_answer_id)
    # end

    # attribute :company_name do | object |
    #   object&.company_page&.company_name
    # end

    # attribute :address do | object |
    #   object&.company_page&.address
    # end

    # attribute :country do | object |
    #   object&.company_page&.country
    # end

    # attribute :company_headquarter do | object |
    #   object&.company_page&.headquarters
    # end

    # attribute :company_photo do |object, params|
    #   host = params[:host] || ''
    #   if object&.company_page&.company_photo&.attached?
    #    url = host + Rails.application.routes.url_helpers.rails_blob_url(
    #         object&.company_page&.company_photo, only_path: true )
    #   end
    # end

    # attribute :company_photo_url do |object, params|
    #   object&.company_page&.image_url
    # end
  end
end