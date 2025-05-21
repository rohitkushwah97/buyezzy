# Protected File
class CreateNotificationSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_settings do |t|
      t.string :title
      t.string :description
      t.integer :state

      t.timestamps
    end
  end
end
