module BxBlockCategories
	class MicroCategory < BxBlockCategories::ApplicationRecord
		self.table_name = :micro_categories

		belongs_to :mini_category, class_name: "BxBlockCategories::MiniCategory", foreign_key: :mini_category_id
		has_one :sub_category, through: :mini_category, class_name: "BxBlockCategories::SubCategory", foreign_key: :sub_category_id
		has_one :category, through: :sub_category, class_name: "BxBlockCategories::Category", foreign_key: :parent_id

		has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue"
		has_many :parent_catalogues, class_name: "BxBlockCatalogue::ParentCatalogue"

		validates :name, uniqueness: true, presence: true

		has_many :custom_fields, as: :fieldable, class_name: "BxBlockCategories::CustomField", dependent: :destroy
		has_many :catalogue_variants, class_name: "BxBlockCatalogue::CatalogueVariant", dependent: :destroy

		accepts_nested_attributes_for :custom_fields, allow_destroy: true

		before_validation :strip_name_whitespace

		private 
		
		def strip_name_whitespace
			self.name = name.strip if name.present?
		end
	end
end