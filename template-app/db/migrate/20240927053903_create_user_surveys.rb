class CreateUserSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :user_surveys do |t|
      t.references :account, null: false, foreign_key: true
      t.references :career_interest, foreign_key: true
      t.bigint :internship_id
      t.bigint :role_id
      t.bigint :version_id
      t.string :quiz_status
      t.timestamps
    end
  end
end
