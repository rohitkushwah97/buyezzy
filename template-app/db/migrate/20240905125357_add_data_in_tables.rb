class AddDataInTables < ActiveRecord::Migration[6.1]
  def change
    add_column :work_schedules, :code, :string
    add_column :work_locations, :code, :string
    schedules = [{schedule: 'part_time', code: "part_time"}, {schedule: 'full_time', code: "full_time"}]
    locations = [{name: 'remote', code: "remote"}, {name: 'in_person', code: "in_person"}, {name: 'hybrid', code: "hybrid"}]

    schedules.each do |schedule|
      BxBlockSettings::WorkSchedule.create(schedule)
    end

    locations.each do |location|
      BxBlockSettings::WorkLocation.create(location)
    end
  end
end
