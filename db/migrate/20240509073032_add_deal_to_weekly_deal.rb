class AddDealToWeeklyDeal < ActiveRecord::Migration[6.0]
  def change
  	add_reference :weekly_deals, :deal, foreign_key: true
  end
end
