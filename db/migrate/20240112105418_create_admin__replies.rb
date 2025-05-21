class CreateAdminReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_replies do |t|
      t.integer :contact_id
      t.text :description
      t.timestamps
    end
  end
end
