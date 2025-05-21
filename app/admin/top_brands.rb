ActiveAdmin.register BxBlockDashboard::TopBrand, as: 'Top Brand' do
	menu parent: 'Home Page'
	permit_params :sequence_no, :brand_id

	form do |f|
		f.semantic_errors
		f.inputs 'Top Brand Details' do
			f.input :brand_id, as: :select, collection: BxBlockCatalogue::Brand.all.where(approve: true).map { |brand| [brand.brand_name, brand.id] }
			f.input :sequence_no
		end

		f.actions
	end

	controller do
		def create
			super do |success, failure|
				failure.html do
					flash[:error] = resource.errors.full_messages.join(', ')
					render :new
				end
			end
		end

		def update
			super do |success, failure|
				failure.html do
					flash[:error] = resource.errors.full_messages.join(', ')
					render :edit
				end
			end
		end
	end

end
