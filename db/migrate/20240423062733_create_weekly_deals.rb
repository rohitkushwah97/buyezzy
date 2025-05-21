class CreateWeeklyDeals < ActiveRecord::Migration[6.0]
  def change
    create_table :weekly_deals do |t|
      t.references :weekly_homiee_deal, null: false, foreign_key: true
      t.string :caption
      t.decimal :discount_percent, precision: 5, scale: 2
      t.string :url

      t.timestamps
    end
  end
end
