module BxBlockCatalogue
	class VariantAttribute < ApplicationRecord
		self.table_name = :variant_attributes

		belongs_to :catalogue_variant, class_name: "BxBlockCatalogue::CatalogueVariant"
		has_many :attribute_options, class_name: "BxBlockCatalogue::AttributeOption", dependent: :destroy
		accepts_nested_attributes_for :attribute_options, allow_destroy: true

		has_many :group_attributes, class_name: "BxBlockCatalogue::GroupAttribute", dependent: :destroy
		validates :attribute_name, presence: true

		before_save :update_group_attributes

		private

		def update_group_attributes
			group_attributes.update_all(attribute_name: attribute_name) if attribute_name_changed?
		end
	end
end