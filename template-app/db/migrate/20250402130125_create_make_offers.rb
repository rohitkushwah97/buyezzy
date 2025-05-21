class CreateMakeOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :make_offers do |t|
      t.references :intern_user, null: false, foreign_key: { to_table: :accounts }
      t.references :business_user, null: false, foreign_key: { to_table: :accounts }
      t.references :internship, null: false, foreign_key: { to_table: :bx_block_navmenu_internships }
      t.integer :offer_status, default: 0, null: false
      t.timestamps
    end
    add_index :make_offers, [:intern_user_id, :internship_id], unique: true

  end
end
