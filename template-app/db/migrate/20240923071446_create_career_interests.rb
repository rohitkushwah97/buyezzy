class CreateCareerInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :career_interests do |t|
      t.bigint :intern_user_id
      t.bigint :industry_id
      t.bigint :role_id
      t.integer :update_count
      t.timestamps
    end
  end
end
