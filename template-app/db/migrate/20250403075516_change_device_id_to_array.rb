class ChangeDeviceIdToArray < ActiveRecord::Migration[6.1]
  def up
    change_column :accounts, :device_id, :text, array: true, default: [], using: "ARRAY[device_id]"
  end

  def down
    change_column :accounts, :device_id, :string
  end

end
