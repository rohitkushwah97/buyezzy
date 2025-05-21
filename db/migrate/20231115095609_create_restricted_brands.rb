class CreateRestrictedBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :restricted_brands do |t|
      t.boolean :approved, default: false
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
