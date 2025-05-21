class CreateStockIntakes < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_intakes do |t|
      t.references :catalogue, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: { to_table: :accounts }
      t.decimal :stock_value
      t.integer :stock_qty
      t.datetime :ship_date
      t.datetime :receiving_date
      t.boolean :status

      t.timestamps
    end
  end
end
