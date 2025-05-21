class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :description
      t.references :created_by, foreign_key: { to_table: :accounts }, index: true
      t.references :created_for, foreign_key: { to_table: :accounts }, index: true

      t.timestamps
    end
  end
end
