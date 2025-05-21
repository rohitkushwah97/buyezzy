class CreateSizeAndCapacities < ActiveRecord::Migration[6.0]
  def change
    create_table :size_and_capacities do |t|
      t.string :size
      t.string :size_unit
      t.string :capacity
      t.string :capacity_unit
      t.string :hs_code
      t.string :prod_model_name
      t.string :prod_model_number
      t.integer :number_of_pieces
      t.references :product_content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
