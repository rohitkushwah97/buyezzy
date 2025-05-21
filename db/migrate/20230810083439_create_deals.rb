class CreateDeals < ActiveRecord::Migration[6.0]
  def change
    create_table :deals do |t|
      t.string :deal_name
      t.string :deal_code
      t.date :start_date
      t.date :end_date
      t.boolean :status

      t.timestamps
    end
  end
end
