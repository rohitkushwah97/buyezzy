class CreateWeeklyHomieeDeals < ActiveRecord::Migration[6.0]
  def change
    create_table :weekly_homiee_deals do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
