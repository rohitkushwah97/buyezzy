class ChangeAccountIdInTermsAndConditions < ActiveRecord::Migration[6.1]
  def change
    rename_column :bx_block_terms_and_conditions_terms_and_conditions, :account_id, :account_type
  end
end
