class CreateUniversity < ActiveRecord::Migration[6.1]
  def change
    create_table :universities do |t|
      t.references :educational_status, null: false, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
