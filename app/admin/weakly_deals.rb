ActiveAdmin.register BxBlockDashboard::WeeklyDeal, as: 'Weekly Deal' do
	permit_params :caption, :discount_percent, :url, :bg_image, :deal_id
	menu if: proc { false }
	form do |f|
		f.semantic_errors *f.object.errors.keys, class: 'inline-errors'
		f.inputs 'Weekly Deal Details' do
			f.input :caption
			f.input :discount_percent
			# f.input :url
			f.input :deal_id, as: :select, collection: BxBlockCatalogue::Deal.all.active_deals.map { |d| [d.deal_name, d.id] }
			if f.object.bg_image.attached?
				f.input :bg_image, as: :file, hint: image_tag(url_for(f.object.bg_image), size: '100x100')
			else
				f.input :bg_image, as: :file
			end
		end
		f.actions
	end

	show do
		attributes_table do
			row :caption
			row :discount_percent
			# row :url
			row :bg_image do |deal|
				image_tag(deal.bg_image, size: '100x100') if deal.bg_image.attached?
			end
			row :deal do |wd|
				if wd.deal.present?
					link_to wd.deal.deal_name, admin_deal_path(wd.deal)
				end
			end
			row :created_at
			row :updated_at
		end
	end

end