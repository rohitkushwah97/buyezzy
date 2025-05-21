# Protected File
# frozen_string_literal: true

# Add year column migration
class AddYearFromYearToAndDescriptionToEducations < ActiveRecord::Migration[6.0]
  def change
    add_column :educations, :year_from, :string
    add_column :educations, :year_to, :string
    add_column :educations, :description, :text
  end
end
