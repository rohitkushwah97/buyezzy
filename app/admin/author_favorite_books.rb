ActiveAdmin.register BxBlockDashboard::AuthorFavoriteBook, as: 'Author Favorite Book' do
	permit_params :title,:status, favorite_book_catalogues_attributes: [:id, :catalogue_id, :_destroy]
	menu parent: 'Home Page'

	filter :title
	filter :favorite_book_catalogues_catalogue_id, as: :select, collection: proc { BxBlockCatalogue::Catalogue.all.where(status: true).order(created_at: :desc).map { |obj| [obj.sku, obj.id] } }, label: "Products"

	form do |f|
		f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
		f.inputs "Author Favorite Book Details" do
			f.input :title
			f.input :status
			f.has_many :favorite_book_catalogues, heading: 'Catalogues', allow_destroy: true do |cs|
				cs.input :catalogue_id, as: :select, collection: BxBlockCatalogue::Catalogue.all.where(status: true).order(created_at: :desc).map { |obj| [obj.sku, obj.id] }, label: 'Catalogue'
			end
		end
		f.actions
	end

	show do
		attributes_table do
			row :title
			row :status
		end

		panel 'Catalogues' do
			table_for resource.favorite_book_catalogues do
				column('ID') { |selection| link_to selection.catalogue_id, admin_product_path(selection.catalogue_id) }
				column :sku do |selection| 
					selection.catalogue.sku 
				end
				column :besku do |selection| 
					selection.catalogue.besku 
				end
				column :product_title do |selection| 
					selection.catalogue&.product_content&.product_title 
				end
				column 'Actions' do |selection|
					link_to 'View', admin_product_path(selection.catalogue_id)
				end
			end
		end
	end
	
end
