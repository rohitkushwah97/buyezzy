module BxBlockCategories
	class CustomFieldsOption < ApplicationRecord
		self.table_name = :custom_fields_options
		belongs_to :custom_field, class_name: "BxBlockCategories::CustomField"
		validates :option_name, presence: true, length: { in: 3..30 }
		before_save :strip_whitespace

		private
		
		def strip_whitespace
			self.option_name = option_name.strip if option_name.present?
		end
	end
end