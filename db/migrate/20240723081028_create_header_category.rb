class CreateHeaderCategory < ActiveRecord::Migration[6.0]
	def change
		create_table :header_categories do |t|
			t.references :category, null: false, foreign_key: true, on_delete: :cascade
			t.integer :sequence_no
			t.index :sequence_no

			t.timestamps
		end
	end
end
