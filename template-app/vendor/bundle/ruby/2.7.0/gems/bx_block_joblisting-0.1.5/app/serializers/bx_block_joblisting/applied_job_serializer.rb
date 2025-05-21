module BxBlockJoblisting
  class AppliedJobSerializer < BuilderBase::BaseSerializer
    attributes(:profile_id, :applied_job_title, :job_id, :applicant_status, :company_page_id, :preffered_location, :preferred_timing, :answer)

    attribute :answer do |object|
      answer =[]
      object.answer.each do |answer|
        BxBlockJoblisting::Answer.find_by(id: answer)
      end
    end

    attribute :applied_date do |object|
      object.created_at
    end

    # attribute  :profiles do | object |
    #   BxBlockProfile::ProfileSerializer.new(object&.profile)
    # end

    attributes :company_page_detail do | object |
      BxBlockJoblisting::CompanyPage.find_by(id: object&.company_page_id)
    end  

    attribute :company_photo do |object, params|
      host = params[:host] || ''
      company_photo = BxBlockJoblisting::CompanyPage.find_by(id: object&.company_page_id)&.company_photo
      if company_photo&.attached? 
       url = host + Rails.application.routes.url_helpers.rails_blob_url(
            company_photo, only_path: true )
      end
    end
    
    attributes :job_details do | object |
      BxBlockJoblisting::Job.find_by(id: object&.job_id)
    end
  end
end
