class AddColumnStatusToCataloguemodels < ActiveRecord::Migration[6.0]
	def change
		add_column :catalogue_contents, :status, :boolean, default: false
		add_column :barcodes, :status, :boolean, default: false
	end
end
