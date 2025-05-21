# Protected File
class CreateNotificationGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_groups do |t|
      t.integer :group_type
      t.string :group_name
      t.references :notification_setting, null: false, foreign_key: true
      t.integer :state

      t.timestamps
    end
  end
end
