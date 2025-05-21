class RevertChangeTypeColumnInReturnReasonDetails < ActiveRecord::Migration[6.0]
   def change
    rename_column :return_reason_details, :type, :reason_type
  end
end
