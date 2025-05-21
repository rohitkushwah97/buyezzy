module BxBlockJoblisting
  class FollowSerializer < BuilderBase::BaseSerializer
    attributes(:id, :profile_id, :followable_id, :followable_type, :is_followed)

    # attribute :company_page_detailddd do | object, params |
    #   company_page = BxBlockJoblisting::CompanyPage.find_by(id: object&.followable_id)
    #   BxBlockJoblisting::CompanyPageSerializer.new(company_page, {params: params})
    # end 

    attribute :company_page_detail do | object |
      company_page = BxBlockJoblisting::CompanyPage.find_by(id: object&.followable_id)
    end 
    
    attributes :company_page_followers do | object, params |
      BxBlockJoblisting::Follow.where(followable_id: object&.followable_id)&.count
    end 

    attribute :company_photo do |object, params|
      host = params[:host] || ''
      company_photo = BxBlockJoblisting::CompanyPage.find_by(id: object&.followable_id)&.company_photo
      if company_photo.attached? 
       url = host + Rails.application.routes.url_helpers.rails_blob_url(
            company_photo, only_path: true )
      end
    end

  end
end