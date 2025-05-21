class CreateBxBlockTermsandconditionsPrivacyAndLegalPolicies < ActiveRecord::Migration[6.0]
  def change
    create_table :bx_block_termsandconditions_privacy_nad_legal_policies do |t|
      t.string :title
      t.text :content
      t.boolean :status
      t.timestamps
    end
  end
end
