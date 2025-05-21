class CreateSupports < ActiveRecord::Migration[6.0]
  def change
    create_table :supports do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :details

      t.timestamps
    end
  end
end
