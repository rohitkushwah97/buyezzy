class CreateCatalogueContents < ActiveRecord::Migration[6.0]
  def change
    create_table :catalogue_contents do |t|
      t.string :custom_field_name
      t.string :value
      t.references :custom_field, null: false, foreign_key: true
      t.references :catalogue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
