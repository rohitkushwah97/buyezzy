class CreateStoreSectionGrid < ActiveRecord::Migration[6.0]
  def change
    create_table :store_section_grids do |t|
    	t.column :grid_name, :string
    	t.column :grid_no, :string
    	t.column :grid_url, :string
    	t.references :store_dashboard_section, null: false, foreign_key: true
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false

    	t.index :grid_name
    	t.index :grid_no
    	t.index :grid_url
    end
  end
end
