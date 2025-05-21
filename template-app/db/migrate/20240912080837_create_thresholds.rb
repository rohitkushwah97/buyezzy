class CreateThresholds < ActiveRecord::Migration[6.1]
  def change
    create_table :thresholds do |t|
      t.integer :threshold_percentage

      t.timestamps
    end
  end
end
