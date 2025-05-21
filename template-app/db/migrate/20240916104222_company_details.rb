class CompanyDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :company_details do |t|
      t.string :company_name
      t.string :website_link
      t.string :contact_number
      t.text :address
      t.text :company_description

      t.belongs_to :country, null: false, foreign_key: true
      t.belongs_to :industry, null: false, foreign_key: true
      t.belongs_to :city, null: false, foreign_key: true
      t.references :business_user, null: false, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
