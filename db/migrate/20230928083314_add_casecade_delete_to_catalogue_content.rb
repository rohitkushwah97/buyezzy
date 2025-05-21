class AddCasecadeDeleteToCatalogueContent < ActiveRecord::Migration[6.0]
	def change
		remove_foreign_key :catalogue_contents, column: :catalogue_id

		add_foreign_key :catalogue_contents, :catalogues, on_delete: :cascade
	end
end
