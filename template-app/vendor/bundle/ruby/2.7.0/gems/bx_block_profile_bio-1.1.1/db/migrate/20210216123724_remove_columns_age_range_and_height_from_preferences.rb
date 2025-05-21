# Protected File
# frozen_string_literal: true

# remove column age range
class RemoveColumnsAgeRangeAndHeightFromPreferences < ActiveRecord::Migration[6.0]
  def change
    remove_column :preferences, :age_range
    remove_column :preferences, :height
  end
end
