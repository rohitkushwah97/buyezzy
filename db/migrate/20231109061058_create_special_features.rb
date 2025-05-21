class CreateSpecialFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :special_features do |t|
      t.string :field_name
      t.string :value
      t.references :product_content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
