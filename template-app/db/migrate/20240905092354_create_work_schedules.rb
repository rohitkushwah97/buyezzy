class CreateWorkSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :work_schedules do |t|
      t.string :schedule
      t.timestamps
    end
  end
end
