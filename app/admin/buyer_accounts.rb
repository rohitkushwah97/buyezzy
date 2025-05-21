ActiveAdmin.register AccountBlock::Account, as: "Buyer Account" do 

	scope "Buyer Accounts", :buyer_accounts, default: true do |accounts|
		accounts.where(user_type: 'buyer')
	end

	permit_params :first_name, :last_name, :full_phone_number, :user_type, :email, :activated, :language

	def buyer_filters
		filter :first_name
		filter :last_name
		filter :full_phone_number
		filter :phone_number
		filter :email
		filter :language, as: :select, collection: ['English']
		filter :activated
		filter :created_at, as: :date_range
		filter :updated_at, as: :date_range
	end

	buyer_filters

	index do
		selectable_column
		id_column
		column :email
		column :first_name
		column :last_name
		column :full_phone_number
		column :user_type
		column :activated
		column :created_at
		column :updated_at
		actions
	end

	show do
		attributes_table do
			row :email
			row :first_name
			row :last_name
			row :full_phone_number
			row :phone_number
			row :user_type
			row :language
			row :activated
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.inputs 'Buyer Details' do
			f.input :email
			f.input :first_name
			f.input :last_name
			f.input :full_phone_number
			f.input :user_type, as: :select, collection: ['seller', 'buyer']
			f.input :language, as: :select, collection: ['English']
			f.input :activated, as: :select, collection: [['Yes', true], ['No', false]]
		end
		f.actions
	end
end