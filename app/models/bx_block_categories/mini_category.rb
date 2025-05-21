module BxBlockCategories
	class MiniCategory < BxBlockCategories::ApplicationRecord
		self.table_name = :mini_categories

		belongs_to :sub_category, class_name: "BxBlockCategories::SubCategory", foreign_key: :sub_category_id
		has_one :category, through: :sub_category, class_name: "BxBlockCategories::Category", foreign_key: :parent_id
		has_many :micro_categories, class_name: "BxBlockCategories::MicroCategory", foreign_key: :mini_category_id, dependent: :destroy

		has_many :catalogues, class_name: "BxBlockCatalogue::Catalogue"
		has_many :parent_catalogues, class_name: "BxBlockCatalogue::ParentCatalogue"

		has_many :custom_fields, as: :fieldable, class_name: "BxBlockCategories::CustomField", dependent: :destroy
		accepts_nested_attributes_for :custom_fields, allow_destroy: true

		validates :name, uniqueness: true, presence: true

		before_validation :strip_name_whitespace

		private 
		
		def strip_name_whitespace
			self.name = name.strip if name.present?
		end
	end
end