class CreateAdminNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_notifications do |t|
      t.string :message, null: false
      
      t.timestamps
    end
  end
end
