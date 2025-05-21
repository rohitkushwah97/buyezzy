# Protected File
# frozen_string_literal: true

# create education
class CreateEducations < ActiveRecord::Migration[6.0]
  def change
    create_table :educations do |t|
      t.string :qualification
      t.integer :profile_bio_id

      t.timestamps
    end
  end
end
