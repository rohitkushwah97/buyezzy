module BxBlockHelpCentre
  class FaqSerializer < BuilderBase::BaseSerializer
    attributes :id, :question, :answer, :created_for, :created_at, :updated_at
  end
end
