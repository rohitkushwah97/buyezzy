class AddVariantAttributeOptionToProdVariant < ActiveRecord::Migration[6.0]
  def change
  	add_column :group_attributes, :variant_attribute_id, :bigint
  	add_column :group_attributes, :attribute_option_id, :bigint
  end
end
