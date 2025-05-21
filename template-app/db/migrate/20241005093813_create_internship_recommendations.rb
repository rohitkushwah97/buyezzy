class CreateInternshipRecommendations < ActiveRecord::Migration[6.1]
  def change
    create_table :internship_recommendations do |t|
      t.bigint :intern_user_id
      t.bigint :internship_id
      t.string :match_type
      t.timestamps
    end
  end
end
