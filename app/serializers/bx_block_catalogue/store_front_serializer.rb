module BxBlockCatalogue
  class StoreFrontSerializer < BuilderBase::BaseSerializer
	attributes :category_id, :brand_id,:warehouse_id, :sku, :besku, :product_title, :status

    	attributes :email do |object|
    		object.seller.email
    	end
    	  attributes :phone_number do |object|
    		object.seller.phone_number
    	end
    	attributes :contact_number do |object|
    		object&.seller&.addresses&.first&.contact_number
    	end
    	attributes :state do |object|
    		object&.seller&.addresses&.first&.state
    	end
    	attributes :city do |object|
    		object&.seller&.addresses&.first&.city
    	end
	attributes :reviews do |object|
	  ReviewSerializer.new(object.review_and_ratings).serializable_hash[:data]
	end
  end
end
