class CreateBarcodes < ActiveRecord::Migration[6.0]
  def change
    create_table :barcodes do |t|
      t.string :bar_code
      t.references :catalogue, foreign_key: true

      t.timestamps
    end
  end
end
