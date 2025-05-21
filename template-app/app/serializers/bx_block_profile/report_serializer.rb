module BxBlockProfile
  class ReportSerializer < BuilderBase::BaseSerializer
    attributes :title, :description, :created_for_id, :created_by_id,:internship_id
  end
end
