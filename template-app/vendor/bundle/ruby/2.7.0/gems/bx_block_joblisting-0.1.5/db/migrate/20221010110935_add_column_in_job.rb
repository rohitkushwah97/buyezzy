class AddColumnInJob < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :sub_emplotyment_type, :string
  end
end
