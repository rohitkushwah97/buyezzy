class AddBibcToCatalogue < ActiveRecord::Migration[6.0]
  def change
  	add_column :catalogues, :bibc, :string
  	add_index :catalogues, :bibc
  end
end
