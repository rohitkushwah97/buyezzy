ActiveAdmin.register BxBlockDashboard::WeeklyHomieeDeal, as: 'Weekly Homiee Deal' do
	menu parent: 'Home Page'
	permit_params :start_time, :end_time, :status, weekly_deals_attributes: [:id, :bg_image, :caption, :discount_percent, :url, :deal_id, :_destroy]

	filter :weekly_deals, as: :select, collection: proc { BxBlockDashboard::WeeklyDeal.all.order(created_at: :desc).map {|wd| [ wd.caption, wd.id ]}}
	filter :start_time
	filter :end_time
	filter :weekly_deals_deal_id, as: :select, collection: proc { BxBlockCatalogue::Deal.all.active_deals.map { |d| [d.deal_name, d.id] } }, label: 'Deal'
	filter :status
	filter :created_at
	filter :updated_at

	form do |f|
		f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
		f.inputs "Weekly Homiee Deal Details" do
			f.input :start_time, as: :date_time_picker
			f.input :end_time, as: :date_time_picker
			f.input :status
			f.has_many :weekly_deals, heading: 'Weekly Deals', allow_destroy: true do |wd|
				wd.input :caption
				wd.input :discount_percent
				# wd.input :url
				wd.input :deal_id, as: :select, collection: BxBlockCatalogue::Deal.all.active_deals.map { |d| [d.deal_name, d.id] }
				if wd.object.bg_image.attached?
					wd.input :bg_image, as: :file, hint: image_tag(url_for(wd.object.bg_image), size: '100x100')
				else
					wd.input :bg_image, as: :file
				end
			end
		end
		f.actions
	end

	show do
		attributes_table do
			row :start_time
			row :end_time
			row :status
		end

		panel 'Weekly Deals' do
			table_for resource.weekly_deals do
				column('ID') { |deal| link_to deal.id, admin_weekly_deal_path(deal) }
				column :caption
				column :discount_percent
				# column :url
				column :deal do |wd|
					if wd.deal.present?
						link_to wd.deal.deal_name, admin_deal_path(wd.deal)
					end
				end
				column :bg_image do |deal|
					image_tag(deal.bg_image, size: '100x100') if deal.bg_image.attached?
				end
				column 'Actions' do |deal|
					link_to 'View', admin_weekly_deal_path(deal)
				end
			end
		end
	end
end