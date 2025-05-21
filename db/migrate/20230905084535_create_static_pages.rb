class CreateStaticPages < ActiveRecord::Migration[6.0]
  def change
    create_table :static_pages do |t|
      t.string :title
      t.text :content
      t.boolean :status

      t.timestamps
    end
  end
end
