# Protected File
class AddDescriptionToTermsAndCondition < ActiveRecord::Migration[6.0]
  def change
    add_column :bx_block_terms_and_conditions_terms_and_conditions, :description, :text
  end
end
