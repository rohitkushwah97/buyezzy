class AddLanguageToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :language, :string
  end
end
