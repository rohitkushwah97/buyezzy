class CreateWorkLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :work_locations do |t|
      t.string :name
      t.timestamps
    end
  end
end
