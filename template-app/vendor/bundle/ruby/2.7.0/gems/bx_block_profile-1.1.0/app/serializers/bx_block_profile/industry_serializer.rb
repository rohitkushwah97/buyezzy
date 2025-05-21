# frozen_string_literal: true

module BxBlockProfile
  class IndustrySerializer < BuilderBase::BaseSerializer
    attributes(:id, :industry_name)
  end
end
