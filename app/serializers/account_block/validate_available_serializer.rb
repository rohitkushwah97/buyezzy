module AccountBlock
  class ValidateAvailableSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :activated

    set_id do |object|
      object.class.name.underscore
    end

    attribute :phone_number do |object|
      object.full_phone_number
    end

    attribute :account_exists do |object|
      object.id.present? ? true : false
    end
  end
end
