class CreateBannerGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :banner_groups do |t|
      t.string :group_name

      t.timestamps
    end
  end
end
