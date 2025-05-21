module BxBlockCatalogue
	class AttributeOption < ApplicationRecord
		self.table_name = :attribute_options

		belongs_to :variant_attribute, class_name: "BxBlockCatalogue::VariantAttribute"

		has_many :group_attributes, class_name: "BxBlockCatalogue::GroupAttribute", dependent: :destroy
		validates :option, presence: true

		before_save :update_group_attributes

		private

		def update_group_attributes
			if option_changed?
				group_attributes.update_all(option: option)
			end
		end
	end
end