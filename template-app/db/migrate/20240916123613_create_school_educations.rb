class CreateSchoolEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :school_educations do |t|
      t.bigint :intern_user_id
      t.bigint :educational_status_id
      t.bigint :school_id
      t.string :school_name
      t.bigint :academic_level_id
      t.string :academic_achievement
      t.string :extracurricular_activity
      t.string :soft_skill
      t.string :interest
      t.string :hobby
      t.timestamps
    end
  end
end
