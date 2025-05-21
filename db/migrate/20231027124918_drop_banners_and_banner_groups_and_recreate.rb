class DropBannersAndBannerGroupsAndRecreate < ActiveRecord::Migration[6.0]
  def up
    drop_table :banners
    drop_table :banner_groups
  end

  def down
    create_table :banner_groups do |t|
      t.string :group_name
      t.timestamps
    end
    add_index :banner_groups, :group_name
    
    create_table :banners do |t|
      t.string :title
      t.text :description
      t.string :button_text
      t.string :button_link
      t.integer :banner_type
      t.integer :section
      t.references :banner_group, foreign_key: true
      t.timestamps
    end

    add_index :banners, :banner_type
    add_index :banners, :section

  end
end
