module BxBlockProjectreporting
  class ProjectSerializer < BuilderBase::BaseSerializer
    attributes *[
     :name,
     :project_type,
     :manager_id,
     :co_manager_id,
     :client_id,
     :start_date,
     :end_date
    ]
    attribute :created_at do |object|
      object.created_at&.strftime('%d %b %Y %-l:%M %p')
    end

    attribute :updated_at do |object|
      object.updated_at&.strftime('%d %b %Y %-l:%M %p')
    end

    attribute :status do |object|
      object.get_status
    end

    attribute :online_tools do |object|
      object.tools.as_json
    end

    attribute :client do |object|
      object.client
    end
    
    attribute :manager do |object|
      object.manager
    end

    attribute :co_manager do |object|
      object.co_manager
    end

  end
end
