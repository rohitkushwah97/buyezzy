class CreateStoreDashboardSection < ActiveRecord::Migration[6.0]
  def change
    create_table :store_dashboard_sections do |t|
    	t.column :section_name, :string
    	t.column :section_type, :string
    	t.column :banner_name, :string
    	t.column :banner_url, :string
    	t.references :store, null: false, foreign_key: true
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false

    	t.index :section_name
    	t.index :section_type
    	t.index :banner_name
    	t.index :banner_url
    end
  end
end
