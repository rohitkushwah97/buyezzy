module BxBlockCatalogue
	class GroupAttribute < ApplicationRecord
		self.table_name = :group_attributes
		belongs_to :product_variant_group, class_name: "BxBlockCatalogue::ProductVariantGroup"
		has_one :catalogue, through: :product_variant_group, class_name: "BxBlockCatalogue::Catalogue"

		belongs_to :variant_attribute, class_name: "BxBlockCatalogue::VariantAttribute", optional: true
		belongs_to :attribute_option, class_name: "BxBlockCatalogue::AttributeOption", optional: true

		validates :attribute_name, :option, presence: true
	end
end