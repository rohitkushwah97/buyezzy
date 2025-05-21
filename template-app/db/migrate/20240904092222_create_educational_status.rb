class CreateEducationalStatus < ActiveRecord::Migration[6.1]
  def change
    create_table :educational_statuses do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
