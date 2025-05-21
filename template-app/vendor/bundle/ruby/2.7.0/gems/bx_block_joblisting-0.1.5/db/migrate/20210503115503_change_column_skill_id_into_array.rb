class ChangeColumnSkillIdIntoArray < ActiveRecord::Migration[6.0]
  def change
    change_column :jobs, :skill_id, :integer, array: true, default: [], using: 'ARRAY[skill_id]::INTEGER[]'
  end
end
