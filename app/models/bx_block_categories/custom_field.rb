module BxBlockCategories
	class CustomField < ApplicationRecord
		self.table_name = :custom_fields
		belongs_to :fieldable, polymorphic: true

		validates :field_name, presence: true, length: { in: 3..30 }, format: { with: /\A[a-zA-Z0-9\s]+\z/, message: "only allows letters, numbers, and spaces" }

		has_many :catalogue_contents, class_name: "BxBlockCatalogue::CatalogueContent", dependent: :destroy
		has_many :custom_fields_options, class_name: "BxBlockCategories::CustomFieldsOption", dependent: :destroy
		accepts_nested_attributes_for :custom_fields_options, allow_destroy: true

		has_many :catalogues, through: :catalogue_contents, class_name: "BxBlockCatalogue::Catalogue"
		before_save :update_catalogue_contents_custom_field_name
		before_save :strip_whitespace
		validate :check_options_presence

		private

		def check_options_presence
			if custom_fields_options.blank?
				errors.add(:base, "At least one custom field option must be present")
			end
		end

		def update_catalogue_contents_custom_field_name
			catalogue_contents.each do |catalogue_content|
				catalogue_content.update(custom_field_name: field_name)
			end
		end

		def strip_whitespace
			self.field_name = field_name.strip if field_name.present?
		end

	end
end