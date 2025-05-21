module AccountBlock
  class SmsOtpSerializer < BuilderBase::BaseSerializer
  	attributes *[
  		:full_phone_number,
	    :pin,
	    :activated,
	    :valid_until,
	    :created_at,
	    :updated_at
  	]
  end
end
