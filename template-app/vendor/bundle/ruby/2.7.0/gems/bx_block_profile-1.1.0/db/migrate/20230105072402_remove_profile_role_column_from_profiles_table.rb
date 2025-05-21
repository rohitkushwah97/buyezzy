# Protected File
class RemoveProfileRoleColumnFromProfilesTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :profile_role, :integer
  end
end
