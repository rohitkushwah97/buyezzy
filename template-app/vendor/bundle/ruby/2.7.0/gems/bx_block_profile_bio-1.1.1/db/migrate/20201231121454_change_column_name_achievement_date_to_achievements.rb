# Protected File
# frozen_string_literal: true

# change column
class ChangeColumnNameAchievementDateToAchievements < ActiveRecord::Migration[6.0]
  def change
    rename_column :achievements, :calendar, :achievement_date
  end
end
