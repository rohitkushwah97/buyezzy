class CreateTermsPolicies < ActiveRecord::Migration[6.0]
  def change
    create_table :terms_policies do |t|
      t.string :page_title
      t.text :content

      t.timestamps
    end
  end
end
