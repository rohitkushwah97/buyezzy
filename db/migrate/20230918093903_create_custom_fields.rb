class CreateCustomFields < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_fields do |t|
      t.string :field_name
      t.string :data_type
      t.boolean :mandatory, default: false
      t.references :fieldable, polymorphic: true

      t.timestamps
    end
  end
end
