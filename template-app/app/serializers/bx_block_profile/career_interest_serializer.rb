module BxBlockProfile
  class CareerInterestSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :created_at, :updated_at)

    attribute :industry do |object|
      { id: object.industry&.id, name: object.industry&.name }
    end

    attribute :role do |object|
      { id: object.role&.id, name: object.role&.name }
    end

    attribute :quiz_status do |object|
      object&.user_survey&.quiz_status
    end

     attribute :retake do |object|
      object&.user_survey&.retake
    end

  end
end