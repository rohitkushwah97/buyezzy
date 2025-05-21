class CreateProductViews < ActiveRecord::Migration[6.0]
  def change
    create_table :product_views do |t|
      t.references :catalogue, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: { to_table: :accounts }
      t.datetime :viewed_at, null: false

      t.timestamps
    end
  end
end
