class CreateBxBlockNavmenuInternships < ActiveRecord::Migration[6.1]
  def change
    create_table :bx_block_navmenu_internships do |t|
      t.date :start_date
      t.date :end_date
      t.string :title
      t.text :description
      t.decimal :monthly_salary

      t.timestamps
    end
  end
end
