module BxBlockJoblisting
  class CompanyPageSerializer < BuilderBase::BaseSerializer
    attributes(:company_name, :website, :company_tagline, :country, :address, :postal_code, :company_description,
               :headquarters, :founded, :specialities, :image_url)

    attribute :followers_count do |object|
      object&.follows&.count
    end

    # attributes :creator_name do |object|
    #   object.account&.first_name
    # end

    attributes :company_page_industries do |object|
      object&.company_page_industries&.first&.industry&.industry_name
    end

    attributes :company_size do |object|
      object&.company_page_company_sizes&.first&.company_size&.size_of_company
    end

    attributes :company_page_company_types do |object|
      object&.company_page_company_types&.first&.company_type&.type_of_company
    end

    attribute :company_photo do |object, params|
      host = params[:host] || ''
      if object.company_photo.attached? 
       url = host + Rails.application.routes.url_helpers.rails_blob_url(
            object.company_photo, only_path: true )
      end
    end

    attribute :jobs do |object|
      object&.jobs
    end

    # attributes :admin_users do | object |
    #  account = object&.admin_users_profiles.where(company_page_id: object.id).account_id
    #   acc = AccountBlock::Account.find_by(id: account)
    # end
    
    # attributes :admin_users_profiles do |object, params|
    #   object&.admin_users_profiles
    #   BxBlockProfile::AdminUserProfileSerializer.new(object&.admin_users_profiles, {params: params})
    # end

    attributes :office_loaction_of_company do | object|
      BxBlockJoblisting::Office.where(company_page_id: object&.id)
    end

    attributes :is_followed do | object, params|
      data = BxBlockJoblisting::Follow.where(followable_id: object&.id, profile_id: params[:profile_id], followable_type: 'BxBlockJoblisting::CompanyPage').pluck(:is_followed).first
      is_followed = (data == true) ? true : false
    end
    
    attribute :office_address do | object |
      object&.office_address
    end  

  end
end
