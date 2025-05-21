module BxBlockCategories
  class IndustrySerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :name, :created_at, :updated_at)

    attribute :roles do |obj, params|
      obj.roles.where.not(id: params[:user].career_interests.pluck(:role_id)) if params.present?
    end
  end
end