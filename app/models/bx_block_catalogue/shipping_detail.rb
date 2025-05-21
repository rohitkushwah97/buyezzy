module BxBlockCatalogue
	class ShippingDetail < ApplicationRecord
		self.table_name = :shipping_details

		SHIPPING_UNITS = ['Kilogram','Gram','Ounce (OZ)','pound (lb)','Centimeter','Meter','Inch','Feet'].freeze
		
		belongs_to :product_content, class_name: "BxBlockCatalogue::ProductContent"
		validates :shipping_length, :shipping_height, :shipping_width, :shipping_weight, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
		validate :validate_unit
		validate :validate_shipping_length_and_unit
		validate :validate_shipping_height_and_unit
		validate :validate_shipping_width_and_unit
		validate :validate_shipping_weight_and_unit

		private

		def validate_unit
			shipping_units = SHIPPING_UNITS.map(&:downcase)
			error_message = "is not valid. It must be one of: #{SHIPPING_UNITS.join(', ')}"
			if shipping_length_unit.present? && !shipping_units.include?(shipping_length_unit.downcase)
				errors.add(:shipping_length_unit, error_message)
			end

			if shipping_height_unit.present? && !shipping_units.include?(shipping_height_unit.downcase)
				errors.add(:shipping_height_unit, error_message)
			end

			if shipping_width_unit.present? && !shipping_units.include?(shipping_width_unit.downcase)
				errors.add(:shipping_width_unit, error_message)
			end

			if shipping_weight_unit.present? && !shipping_units.include?(shipping_weight_unit.downcase)
				errors.add(:shipping_weight_unit, error_message)
			end
		end

		def validate_shipping_length_and_unit
			if shipping_length.present? && shipping_length_unit.blank?
				errors.add(:shipping_length_unit, "must be present if shipping_length is provided")
			elsif shipping_length_unit.present? && shipping_length.blank?
				errors.add(:shipping_length, "must be present if shipping_length_unit is provided")
			else
				true
			end
		end

		def validate_shipping_height_and_unit
			if shipping_height.present? && shipping_height_unit.blank?
				errors.add(:shipping_height_unit, "must be present if shipping_height is provided")
			elsif shipping_height_unit.present? && shipping_height.blank?
				errors.add(:shipping_height, "must be present if shipping_height_unit is provided")
			else
				true
			end
		end

		def validate_shipping_width_and_unit
			if shipping_width.present? && shipping_width_unit.blank?
				errors.add(:shipping_width_unit, "must be present if shipping_width is provided")
			elsif shipping_width_unit.present? && shipping_width.blank?
				errors.add(:shipping_width, "must be present if shipping_width_unit is provided")
			else
				true
			end
		end

		def validate_shipping_weight_and_unit
			if shipping_weight.present? && shipping_weight_unit.blank?
				errors.add(:shipping_weight_unit, "must be present if shipping_weight is provided")
			elsif shipping_weight_unit.present? && shipping_weight.blank?
				errors.add(:shipping_weight, "must be present if shipping_weight_unit is provided")
			else
				true
			end
		end
	
	end
end