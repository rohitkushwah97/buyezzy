module BxBlockProfile
  class UniversityEducationSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :specialisation, :graduation_year, :created_at, :updated_at)

    attribute :educational_status do |object|
      { id: object.educational_status.id, name: object.educational_status.name }
    end

    attribute :university do |object|
      { id: object.university.id, name: object.university.name }
    end

    attribute :university_name do |object|
      object.university_name
    end

  end
end