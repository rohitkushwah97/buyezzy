class CreateSellerDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :seller_documents do |t|
      t.string :document_type
      t.string :document_name
      t.json :document_files
      t.string :vat_reason
      t.string :iban
      t.string :bank_address
      t.string :name
      t.string :bank_name
      t.string :swift_code
      t.string :account_no
      t.boolean :approved
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
