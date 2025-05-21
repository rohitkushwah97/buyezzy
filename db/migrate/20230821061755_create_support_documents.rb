class CreateSupportDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :support_documents do |t|
      t.string :page_title
      t.text :content

      t.timestamps
    end
  end
end
