class AddSectionToSellerStaticPage < ActiveRecord::Migration[6.0]
  def change
  	add_column :seller_static_pages, :section, :string, default: 'header'
  	add_index :seller_static_pages, :section
  end
end
