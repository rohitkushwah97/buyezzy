class CreateRequestInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :request_interviews do |t|
      t.references :intern_user, null: false, foreign_key: { to_table: :accounts }
      t.references :business_user, null: false, foreign_key: { to_table: :accounts }
      t.references :internship, null: false, foreign_key: { to_table: :bx_block_navmenu_internships }
      t.integer :status, default: 0, null: false
      t.integer :number_of_days, null: false
      t.timestamps
    end
    add_index :request_interviews, [:intern_user_id, :internship_id], unique: true

  end
end

