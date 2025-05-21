module BxBlockSurveys
  class InternCharacteristicImportanceSerializer < BuilderBase::BaseSerializer
    attributes :intern_characteristic_id,:value

    attribute :name do |object|
      object&.intern_characteristic&.name
    end
  end
end
