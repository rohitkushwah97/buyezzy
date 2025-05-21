class CreateSeoSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :seo_settings do |t|
      t.string :page_name
      t.string :meta_title
      t.string :meta_description

      t.timestamps
    end
  end
end
