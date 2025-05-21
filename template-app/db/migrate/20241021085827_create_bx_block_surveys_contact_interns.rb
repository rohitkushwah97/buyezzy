class CreateBxBlockSurveysContactInterns < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_interns do |t|
      t.integer :decision,default: 0
      t.bigint :internship_id, null: false
      t.bigint :intern_user_id, null: false

      t.timestamps
    end
  end
end
