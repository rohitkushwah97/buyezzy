module BuilderBase
  class ErrorSerializer < BuilderBase::BaseSerializer
    attribute :errors do |object|
      object.errors.as_json
    end
  end
end
