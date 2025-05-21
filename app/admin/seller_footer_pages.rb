ActiveAdmin.register BxBlockTermsandconditions::SellerStaticPage, as: 'Seller Footer Pages' do
	permit_params :title, :content, :status, :section

	actions :index, :show, :edit, :update

	controller do
		def scoped_collection
			super.footer_pages
		end
	end

	index do 
		column :title
		column :content do |static|
			truncate(strip_tags(static.content), length: 30)
		end
		actions
	end

	form do |f|
		f.inputs 'Seller Footer Page' do
			f.input :title, as: :select, collection: ['Privacy notice','Terms of service','Cost & Commission details',"Beginner's guide",'Fulfillment by ByEzzy','Fulfillment by Partner','Advertise on ByEzzy','Brand store']
			f.input :content, as: :ckeditor, input_html: { value: f.object.content.presence || "No content available. Please provide content." }
			f.input :status
		end
		f.actions
	end

	show do
		attributes_table do
			row :title
			row :content do |static_page|
				static_page.content&.html_safe
			end
			row :status
		end
	end

end
