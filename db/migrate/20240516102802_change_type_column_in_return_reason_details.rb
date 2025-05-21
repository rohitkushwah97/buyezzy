class ChangeTypeColumnInReturnReasonDetails < ActiveRecord::Migration[6.0]
  def change
  	change_column :return_reason_details, :type, 'integer USING CAST(type AS integer)'
  end
end
