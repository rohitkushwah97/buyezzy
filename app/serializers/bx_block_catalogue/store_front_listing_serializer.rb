module BxBlockCatalogue
	class StoreFrontListingSerializer < BuilderBase::BaseSerializer
		attributes :description, :title, :rating
		attributes :name do |object|
			object.account.full_name
		end
		attributes :created_at do |object|
			object.created_at.strftime("%d/%m/%y")
		end
	end
end
