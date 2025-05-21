class CreateReturnReasonDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :return_reason_details do |t|
      t.string :title
      t.text :details
      t.references :shopping_cart_order_item, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
