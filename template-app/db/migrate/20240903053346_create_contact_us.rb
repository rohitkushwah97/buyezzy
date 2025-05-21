class CreateContactUs < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_us do |t|
      t.string :full_name, null: false
      t.string :email, null: false
      t.references :issue_type, null: false, foreign_key: true
      t.text :inquiry_details, null: false, limit: 500

      t.timestamps
    end
  end
end
