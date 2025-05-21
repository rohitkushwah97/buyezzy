module BxBlockCatalogue
	class SizeAndCapacity < ApplicationRecord
		self.table_name = :size_and_capacities

		SIZE_UNITS = ['Grams', 'Kilograms', 'Centimeter', 'Millimeter'].freeze
		CAPACITY_UNITS = ['Litre', 'Millilitre'].freeze

		belongs_to :product_content, class_name: "BxBlockCatalogue::ProductContent"

		validates :size,:capacity,:number_of_pieces, allow_blank: true, numericality: { greater_than_or_equal_to: 0 }
		validates :prod_model_number, allow_blank: true, format: { with: /\A[a-zA-Z0-9!@#$%^&*()_+-={}\[\]:;"'<>,.?\/\\|`~\s]{3,16}\z/, message: "must be alphanumeric, special characters and between 3 to 16 characters long" }

		validates :hs_code, format: { with: /\A\d{6}\z/, message: "should be a 6-digit numeric code" }, unless: :hs_code_blank
		validate :validate_unit
		validate :validate_size_and_unit
		validate :validate_capacity_and_unit

		private

		def validate_unit
			size_units = SIZE_UNITS.map(&:downcase)
			if size_unit.present? && !size_units.include?(size_unit.downcase)
				errors.add(:size_unit, "is not valid. It must be one of: #{SIZE_UNITS.join(', ')}")
			end

			capacity_units = CAPACITY_UNITS.map(&:downcase)
			if capacity_unit.present? && !capacity_units.include?(capacity_unit.downcase)
				errors.add(:capacity_unit, "is not valid. It must be one of: #{CAPACITY_UNITS.join(', ')}")
			end
		end

		def validate_size_and_unit
			if size.present? && size_unit.blank?
				errors.add(:size_unit, "must be present if size is provided")
			elsif size_unit.present? && size.blank?
				errors.add(:size, "must be present if size_unit is provided")
			else
				true
			end
		end

		def validate_capacity_and_unit
			if capacity.present? && capacity_unit.blank?
				errors.add(:capacity_unit, "must be present if capacity is provided")
			elsif capacity_unit.present? && capacity.blank?
				errors.add(:capacity, "must be present if capacity_unit is provided")
			else
				true
			end
		end

		def hs_code_blank
			hs_code.blank?
		end
	end
end