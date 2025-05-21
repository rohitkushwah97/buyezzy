class CreateBanners < ActiveRecord::Migration[6.0]
	def change
		create_table :banners do |t|
			t.string :title
			t.text :description
			t.string :button_text
			t.string :button_link
			t.integer :banner_type
			t.integer :section
			# t.references :banner_group, foreign_key: { to_table: :banners }
			t.timestamps
		end

		
		add_index :banners, :banner_type
		add_index :banners, :section
	end
end
