class CreatePrivacyPolicies < ActiveRecord::Migration[6.1]
  def change
    create_table :privacy_policies do |t|
      t.integer :account_type
      t.text :description
      t.timestamps
    end
  end
end
