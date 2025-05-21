module AccountBlock
  class UserDeliveryAddressSerializer < BuilderBase::BaseSerializer

  	attributes *[
      :first_name, :last_name, :address_1, :address_2, :phone_number, :state, :city, :zip_code, :address_type,  :account_id, :is_default
    ]

  end
end