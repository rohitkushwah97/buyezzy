class CreateUniversityEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :university_educations do |t|
      t.bigint :intern_user_id
      t.bigint :educational_status_id
      t.bigint :university_id
      t.string :university_name
      t.string :specialisation
      t.integer :graduation_year
      t.timestamps
    end
  end
end
