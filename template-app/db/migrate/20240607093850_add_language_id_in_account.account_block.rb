# This migration comes from account_block (originally 20210303080049)
# Protected File
class AddLanguageIdInAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :app_language_id, :integer
  end
end
