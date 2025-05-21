module BxBlockProfile
  class SchoolEducationSerializer
    include FastJsonapi::ObjectSerializer

    attributes(:id, :academic_achievement, :extracurricular_activity, :soft_skill, :interest, :hobby, :created_at, :updated_at)

    attribute :educational_status do |object|
      { id: object.educational_status.id, name: object.educational_status.name }
    end

    attribute :school do |object|
      { id: object.school.id, name: object.school.name }
    end

    attribute :school_name do |object|
      object.school_name
    end

    attribute :academic_level do |object|
      { id: object.academic_level.id, name: object.academic_level.name }
    end

  end
end