# Protected File
class CreateNotificationSubgroups < ActiveRecord::Migration[6.0]
  def change
    create_table :notification_subgroups do |t|
      t.integer :subgroup_type
      t.string :subgroup_name
      t.references :notification_group, null: false, foreign_key: true
      t.integer :state

      t.timestamps
    end
  end
end
