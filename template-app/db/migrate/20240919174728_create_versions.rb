class CreateVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :versions do |t|
      t.integer :survey_id
      t.string :name

      t.timestamps
    end
  end
end
