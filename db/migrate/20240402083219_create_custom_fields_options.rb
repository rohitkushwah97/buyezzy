class CreateCustomFieldsOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_fields_options do |t|
      t.string :option_name
      t.references :custom_field, null: false, foreign_key: true
      t.index :option_name

      t.timestamps
    end
  end
end
