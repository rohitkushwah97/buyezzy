module BxBlockCatalogue
	class ImageUrl < ApplicationRecord
		self.table_name = :image_urls
		
		belongs_to :product_content, class_name: "BxBlockCatalogue::ProductContent"

		validates :url, presence: true, format: { with: /\A(?:https:\/\/|www\.)[^\s]+\z/, message: "should start with 'https://' or 'www.'" }
	end
end	