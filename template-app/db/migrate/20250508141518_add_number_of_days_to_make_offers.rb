class AddNumberOfDaysToMakeOffers < ActiveRecord::Migration[6.1]
  def change
    add_column :make_offers, :number_of_days, :integer
  end
end
